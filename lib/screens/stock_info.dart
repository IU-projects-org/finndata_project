import 'dart:convert';

import 'package:finndata_project/models/stock_info.dart';
import 'package:finndata_project/repos/finn_api_repo.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StockInfoScreen extends StatefulWidget {
  const StockInfoScreen(
      {Key? key, required this.title, required this.symbolQuery})
      : super(key: key);

  final String title, symbolQuery;

  @override
  State<StockInfoScreen> createState() => _StockInfoScreenState();
}

class _StockInfoScreenState extends State<StockInfoScreen> {
  late WebSocketChannel _channel;

  late Map<String, dynamic> _profile; // ignore: unused_field
  late Map<String, dynamic> _financial; // ignore: unused_field

  double _currentRate = 0;

  Future<void> _fetchContent() async {
    await finnApiRepo.fetchQuote(widget.symbolQuery).then((quoteResponse) {
      if (quoteResponse.containsKey('c')) {
        setState(() {
          _currentRate = quoteResponse['c'];
        });
      }
    });
    await finnApiRepo
        .fetchCompanyProfile(widget.symbolQuery)
        .then((profileResponse) {
      setState(() {
        _profile = profileResponse;
      });
    });
    await finnApiRepo
        .fetchBasicFinancial(widget.symbolQuery)
        .then((financialResponse) {
      setState(() {
        _financial = financialResponse;
      });
    });
  }

  void _startPollingRates() {
    void _processWSResponse(dynamic wsResponse) {
      final parsedResponse = WSResponse.fromJson(jsonDecode(wsResponse));
      if (parsedResponse.stockChanges.isNotEmpty) {
        int _latestChangeTimestamp = 0;
        for (final stockChange in parsedResponse.stockChanges) {
          if (stockChange.timestamp > _latestChangeTimestamp) {
            _latestChangeTimestamp = stockChange.timestamp;
            setState(() {
              _currentRate = stockChange.lastPrice;
            });
          }
        }
      }
    }

    _channel =
        finnApiRepo.initWSChannel(widget.symbolQuery, _processWSResponse);
  }

  @override
  void initState() {
    _fetchContent();
    _startPollingRates();
    super.initState();
  }

  @override
  void deactivate() {
    _channel.sink.close();
    super.deactivate();
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
              indicatorColor: Colors.black,
            ),
            backgroundColor: Colors.black,
          ),
          body: TabBarView(children: [
            Container(
              color: Colors.white,
              child: Center(
                  child: Text(
                'Current price: $_currentRate\$',
                style: const TextStyle(fontSize: 54),
              )),
            ),
            Container(
              color: Colors.white,
              child: const Center(
                  child: Text(
                'Soon :)',
                style: TextStyle(fontSize: 54),
              )),
            ),
            Container(
              color: Colors.white,
              child: const Center(
                  child: Text(
                'Soon :)',
                style: TextStyle(fontSize: 54),
              )),
            ),
          ]),
        ),
      ),
    );
  }
}
