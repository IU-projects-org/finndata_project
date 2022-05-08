import 'package:finndata_project/screens/market_news.dart';
import 'package:finndata_project/screens/search.dart';
import 'package:finndata_project/widgets/settings_buttom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/finn/api_cubit.dart';
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
    if (index == 0) {
      BlocProvider.of<APICubit>(context).loadNews();
    } else if (index == 1) {
      BlocProvider.of<APICubit>(context).loadSearchResults('');
    } else {
      BlocProvider.of<APICubit>(context).cancelLoading();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    BlocProvider.of<APICubit>(context).loadNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          _selectedIndex == 0
              ? 'Market News'
              : _selectedIndex == 1
                  ? 'Search on Symbol Stock'
                  : 'Saved Stocks',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon:
                Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
            onPressed: () async {
              await showSettingsBottomDialog(context);
            },
          )
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        unselectedItemColor: const Color(0xFF707070),
        selectedItemColor: Theme.of(context).iconTheme.color,
        selectedFontSize: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: SafeArea(child: screens[_selectedIndex]),
    );
  }
}
