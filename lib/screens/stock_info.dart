import 'dart:convert';

import 'package:finndata_project/repos/finn_api_repo.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StockChange {
  final String symbol;
  final double lastPrice;
  final int timestamp;

  StockChange(this.symbol, this.lastPrice, this.timestamp);

  StockChange.fromJson(Map<String, dynamic> json)
      : symbol = json['s'],
        lastPrice = json['p'],
        timestamp = json['t'];
}

class WSResponse {
  final String type;
  final List<StockChange> stockChanges;

  WSResponse({required this.type, required this.stockChanges});

  factory WSResponse.fromJson(Map<String, dynamic> json) {
    final _type = json['type'] as String;

    List<StockChange> _stockChanges = [];
    if (_type == 'trade') {
      for (var item in json['data']) {
        final stockChange = StockChange.fromJson(item as Map<String, dynamic>);
        _stockChanges.add(stockChange);
      }
    }

    return WSResponse(type: _type, stockChanges: _stockChanges);
  }
}

class StockInfoScreen extends StatefulWidget {
  const StockInfoScreen(
      {Key? key, required this.title, required this.symbolQuery})
      : super(key: key);

  final String title, symbolQuery;

  @override
  State<StockInfoScreen> createState() => _StockInfoScreenState();
}

class _StockInfoScreenState extends State<StockInfoScreen> {
  late Map<String, dynamic> _profile;
  late Map<String, dynamic> _financials;

  double _currentRate = 0.0;

  _fetchContent() async {
    await finnApiRepo.fetchCompanyProfile(widget.symbolQuery).then((response) {
      setState(() {
        _profile = response;
      });
    });
    await finnApiRepo.fetchBasicFinancials(widget.symbolQuery).then((response) {
      setState(() {
        _financials = response;
      });
    });
  }

  void _startPollingRates() {
    void _processWSResponse(dynamic wsResponse) {
      var parsedResponse = WSResponse.fromJson(jsonDecode(wsResponse));
      if (parsedResponse.stockChanges.isNotEmpty) {
        int _latestChangeTimestamp = 0;
        for (var stockChange in parsedResponse.stockChanges) {
          if (stockChange.timestamp > _latestChangeTimestamp) {
            _latestChangeTimestamp = stockChange.timestamp;
            setState(() {
              _currentRate = stockChange.lastPrice;
            });
          }
        }
      }
    }

    final WebSocketChannel _ =
        finnApiRepo.initWSChannel(widget.symbolQuery, _processWSResponse);
  }

  @override
  initState() {
    _fetchContent();
    _startPollingRates();
    super.initState();
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
            Container(
              child: Center(
                  child: Text(
                'Current price: $_currentRate\$',
                style: const TextStyle(fontSize: 54),
              )),
              color: Colors.yellow.shade100,
            ),
            Text('$_profile'),
            Text('$_financials'),
          ]),
        ),
      ),
    );
  }
}
