import 'package:finndata_project/models/api_result.dart';
import 'package:finndata_project/models/market_news.dart';
import 'package:finndata_project/models/symbol_result.dart';
import 'package:finndata_project/repos/finn_api_repo.dart';
import 'package:finndata_project/utils/api_rest.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'finn_api_repo_test.mocks.dart';

const String _token = 'c8s8j92ad3ifkeao31rg';

@GenerateMocks([DioClient])
void main() {

  late MockDioClient mockDioClient;
  late FinnHubAPIRepository testFinnApiRepo;

  setUpAll(() {
    mockDioClient = MockDioClient();
    testFinnApiRepo = FinnHubAPIRepository();

    // ignore: cascade_invocations
    testFinnApiRepo.dioClient = mockDioClient;
  });

  group('getMarketNews', () {

    test('Works correctly on emptry response', () async {
      when(mockDioClient.get('news?category=general', queryParameters: {'token': _token}))
        .thenAnswer((_) async => []);
    
      final ApiResult<List<MarketModel>> result = await testFinnApiRepo.getMarketNews();
      expect(result, const ApiResult<List<MarketModel>>.success(data: []));
    });

    test('Works correctly on not empty response', () async {
      const Map<String, dynamic> marketModelJson = {
        'id': 1,
        'datetime': 1,
        'category': 'category',
        'headline': 'headline',
        'image': 'image',
        'related': 'related',
        'source': 'source',
        'summary': 'summary',
        'url': 'url',
      };

      when(mockDioClient.get('news?category=general', queryParameters: {'token': _token}))
        .thenAnswer((_) async => [marketModelJson, ]);

      final ApiResult<List<MarketModel>> result = await testFinnApiRepo.getMarketNews();
      expect(result, ApiResult<List<MarketModel>>.success(data: [
        MarketModel.fromJson(marketModelJson), 
      ]));
    });
  });

  group('getQueryStocks', () {

    test('Works correctly on emptry response', () async {
      when(mockDioClient.get('search?q=query', queryParameters: {'token': _token}))
        .thenAnswer((_) async => {'result': []});

      final ApiResult<List<SymbolResultModel>> result = await testFinnApiRepo.getQueryStocks('query');
      expect(result, const ApiResult<List<SymbolResultModel>>.success(data: []));
    });

    test('Works correctly on not empty response', () async {
      const Map<String, dynamic> symbolResultModelJson = {
        'description': 'description',
        'displaySymbol': 'displaySymbol',
        'symbol': 'symbol',
        'type': 'type',
      };

      when(mockDioClient.get('search?q=query', queryParameters: {'token': _token}))
        .thenAnswer((_) async => {'result': [symbolResultModelJson, ]});

      final ApiResult<List<SymbolResultModel>> result = await testFinnApiRepo.getQueryStocks('query');
      expect(result, ApiResult<List<SymbolResultModel>>.success(data: [
        SymbolResultModel.fromJson(symbolResultModelJson), 
      ]));
    });
  });

}
