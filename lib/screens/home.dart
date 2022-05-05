import 'package:finndata_project/bloc/finn/api_cubit.dart';
import 'package:finndata_project/repos/finn_api_repo.dart';
import 'package:finndata_project/screens/market_news.dart';
import 'package:finndata_project/screens/search.dart';
import 'package:finndata_project/widgets/settings_buttom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_stocks.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    const MarketNews(),
    const SearchScreen(),
    const MyStocksList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FinnHubAPIRepository(),
      child: BlocProvider(
        create: (context) => APICubit(
          apiRepository: RepositoryProvider.of<FinnHubAPIRepository>(context),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            title: Text(
              _selectedIndex == 0
                  ? 'Market News'
                  : _selectedIndex == 1
                      ? 'Search on Symbol Stock'
                      : 'Saved Stocks',
              style: const TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () async {
                  await showSettingsBottomDialog(context);
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
              BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
          body: SafeArea(child: screens[_selectedIndex]),
        ),
      ),
    );
  }
}
