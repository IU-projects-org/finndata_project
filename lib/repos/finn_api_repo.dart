import 'package:dio/dio.dart';

const String token = 'c8rdafiad3i8tv0k57n0';

class FinnHubAPIRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://finnhub.io/api/v1';
  final String _tokenParam = 'token=$token';

  Future<Map<String, dynamic>> fetchCompanyProfile(String symbol) async {
    try {
      Response response = await _dio
          .get('$_baseUrl/stock/profile2?symbol=$symbol&$_tokenParam');
      return response.data;
    } on Exception catch (exc) {
      throw Exception('Not found. Origin: $exc');
    }
  }

  Future<Map<String, dynamic>> fetchBasicFinancials(String symbol) async {
    try {
      Response response = await _dio
          .get('$_baseUrl/stock/metric?symbol=$symbol&metric=all&$_tokenParam');
      return response.data;
    } on Exception catch (exc) {
      throw Exception('Not found. Origin: $exc');
    }
  }

  fetchMarketNews(String category) async {
    try {
      Response response =
          await _dio.get('$_baseUrl/news?category=$category&$_tokenParam');
      return response.data as List;
    } on Exception catch (exc) {
      throw Exception('Not found. Origin: $exc');
    }
  }
}

final FinnHubAPIRepository finnApiRepo = FinnHubAPIRepository();
