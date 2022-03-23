import 'package:finndata_project/repos/finn_api_repo.dart';
import 'package:flutter/material.dart';

class StockInfoScreen extends StatefulWidget {
  const StockInfoScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StockInfoScreen> createState() => _StockInfoScreenState();
}

class _StockInfoScreenState extends State<StockInfoScreen> {
  Map<String, dynamic>? _profile;
  Map<String, dynamic>? _financials;

  void _fetchContent() {
    finnApiRepo.fetchCompanyProfile('AAPL').then((response) {
      setState(() {
        _profile = response;
      });
    });
    finnApiRepo.fetchBasicFinancials('AAPL').then((response) {
      setState(() {
        _financials = response;
      });
    });
  }

  _StockInfoScreenState() {
    _fetchContent();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Details'),
                Tab(text: 'Description'),
                Tab(text: 'Fundamentals'),
              ],
            ),
          ),
          body: TabBarView(children: [
            Text('$_profile'),
            Text('$_financials'),
            const Text('3'),
          ]),
        ),
      ),
    );
  }
}
