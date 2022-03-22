import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef Handler<String> = void Function(String event);
const String token = 'c8rdafiad3i8tv0k57n0';

class StockInfoAPIRepository {
  final Dio _dio = Dio();
  final String _baseAPIUrl = 'https://finnhub.io/api/v1';
  final String _baseWSUrl = 'wss://ws.finnhub.io';
  final String _tokenParam = 'token=$token';

  Future<Map<String, dynamic>> fetchCompanyProfile(String symbol) async {
    try {
      Response response = await _dio.get(
        '$_baseAPIUrl/stock/profile2?symbol=$symbol&$_tokenParam'
      );
      return response.data;
    } on Exception catch (exc) {
      throw Exception('Not found. Origin: $exc');
    }
  }

  Future<Map<String, dynamic>> fetchBasicFinancials(String symbol) async {
    try {
      Response response = await _dio.get(
        '$_baseAPIUrl/stock/metric?symbol=$symbol&metric=all&$_tokenParam'
      );
      return response.data;
    } on Exception catch (exc) {
      throw Exception('Not found. Origin: $exc');
    }
  }

  WebSocketChannel initWSChannel(String symbol, Handler<dynamic> handler) {
    // Init the channel
    final channel = WebSocketChannel.connect(
      Uri.parse('$_baseWSUrl?$_tokenParam')
    );

    // Subscribe to the changes of a particular symbol
    channel.sink.add(
      jsonEncode({
        'type': 'subscribe',
        'symbol': symbol
      })
    );

    // Set up events handler
    channel.stream.listen(
      handler,
      onError: print,
    );

    return channel;
  }

}

final StockInfoAPIRepository stockInfoRepo = StockInfoAPIRepository();
