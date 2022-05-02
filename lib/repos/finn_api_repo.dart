import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/market_news.dart';
import '../models/symbol_result.dart';

typedef Handler<String> = void Function(String event);
const String token = 'c8rdafiad3i8tv0k57n0';

class FinnHubAPIRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://finnhub.io/api/v1';
  final String _baseWSUrl = 'wss://ws.finnhub.io';
  final String _tokenParam = 'token=$token';

  Future<dynamic> _fetch(String url) async {
    try {
      final Response response = await _dio.get(url);
      return response.data;
    } on Exception catch (exc) {
      throw Exception('Not found. Origin: $exc');
    }
  }

  Future<Map<String, dynamic>> fetchQuote(String symbol) async {
    return await _fetch('$_baseUrl/quote?symbol=$symbol&$_tokenParam');
  }

  Future<Map<String, dynamic>> fetchCompanyProfile(String symbol) async {
    return await _fetch('$_baseUrl/stock/profile2?symbol=$symbol&$_tokenParam');
  }

  Future<Map<String, dynamic>> fetchBasicFinancials(String symbol) async {
    return await _fetch(
        '$_baseUrl/stock/metric?symbol=$symbol&metric=all&$_tokenParam');
  }

  Future<List<dynamic>> fetchMarketNews(String category) async {
    return await _fetch('$_baseUrl/news?category=$category&$_tokenParam')
        as List;
  }

  Future<List<dynamic>> searchQuery(String q) async {
    final response = await _fetch('$_baseUrl/search?q=$q&$_tokenParam');
    return response['result'] as List;
  }

  WebSocketChannel initWSChannel(String symbol, Handler<dynamic> handler) {
    // Init the channel
    final channel =
        WebSocketChannel.connect(Uri.parse('$_baseWSUrl?$_tokenParam'));

    // Subscribe to the changes of a particular symbol
    channel.sink.add(jsonEncode({'type': 'subscribe', 'symbol': symbol}));

    // Set up events handler
    channel.stream.listen(
      handler,
      onError: print,
    );

    return channel;
  }

  Future<List<MarketModel>> getMarketNews() async {
    final results = await fetchMarketNews('general');
    final List<MarketModel> news = results
        .map((value) => MarketModel.fromJson(value as Map<String, dynamic>))
        .toList();
    return news;
  }

  Future<List<SymbolResultModel>> getQueryStocks(String query) async {
    final results = await searchQuery(query);
    final List<SymbolResultModel> resultModel = results
        .map((value) =>
            SymbolResultModel.fromJson(value as Map<String, dynamic>))
        .toList();
    return resultModel;
    // return result;
  }
}

final FinnHubAPIRepository finnApiRepo = FinnHubAPIRepository();
