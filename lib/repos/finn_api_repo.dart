import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/api_result.dart';
import '../models/market_news.dart';
import '../models/network_exceptions.dart';
import '../models/symbol_result.dart';
import '../utils/api_rest.dart';

typedef Handler<String> = void Function(String event);
const String _token = 'c8s8j92ad3ifkeao31rg';

class FinnHubAPIRepository {
  FinnHubAPIRepository() {
    final dio = Dio();

    dioClient = DioClient(_baseUrl, dio);
  }
  late DioClient dioClient;
  final String _baseUrl = 'https://finnhub.io/api/v1/';
  final String _baseWSUrl = 'wss://ws.finnhub.io';
  final String _tokenParam = 'token=$_token';

  Future<Map<String, dynamic>> fetchQuote(String symbol) async {
    return await dioClient
        .get('quote?symbol=$symbol', queryParameters: {'token': _token});
  }

  Future<Map<String, dynamic>> fetchCompanyProfile(String symbol) async {
    return await dioClient.get('stock/profile2?symbol=$symbol',
        queryParameters: {'token': _token});
  }

  Future<Map<String, dynamic>> fetchBasicFinancial(String symbol) async {
    return await dioClient.get('stock/metric?symbol=$symbol',
        queryParameters: {'token': _token, 'metric': 'all'});
  }

  Future<List<dynamic>> fetchMarketNews(String category) async {
    return await dioClient.get('news?category=$category',
        queryParameters: {'token': _token}) as List;
  }

  Future<List<dynamic>> searchQuery(String q) async {
    final response =
        await dioClient.get('search?q=$q', queryParameters: {'token': _token});
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

  Future<ApiResult<List<MarketModel>>> getMarketNews() async {
    try {
      final results = await fetchMarketNews('general');
      final List<MarketModel> news = results
          .map((value) => MarketModel.fromJson(value as Map<String, dynamic>))
          .toList();
      return ApiResult.success(data: news);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List<SymbolResultModel>>> getQueryStocks(
      String query) async {
    try {
      final results = await searchQuery(query);
      final List<SymbolResultModel> resultModel = results
          .map((value) =>
              SymbolResultModel.fromJson(value as Map<String, dynamic>))
          .toList();
      return ApiResult.success(data: resultModel);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}

final FinnHubAPIRepository finnApiRepo = FinnHubAPIRepository();
