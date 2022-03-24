import 'package:finndata_project/screens/main.dart';
import 'package:finndata_project/screens/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

_signOut() async {
  await _firebaseAuth.signOut();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    const MainScreen(),
    const SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          _selectedIndex == 0 ? 'Market News' : 'Search on Symbol Stock',
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        title: const Text('Exiting the application'),
                        content: const Text('Are you sure you want to exit?'),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.black54.withOpacity(0.1)))),
                          TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await _signOut();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.black54.withOpacity(0.1))))
                        ],
                      ));
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: const Color(0xFF707070),
        selectedFontSize: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      body: SafeArea(child: screens[_selectedIndex]),
    );
  }
}
