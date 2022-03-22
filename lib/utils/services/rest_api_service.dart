// import 'dart:async';
// import 'dart:convert';
//
// import 'package:finndata_project/models/stock_model.dart';
// import 'package:http/http.dart' as http;
//
// import '../helpers/text_helpter.dart';
//
// class StockApiClient {
//   static const baseUrl = 'https://finnhub.io';
//   static const apiKey = 'c8s8j92ad3ifkeao31rg';
//   final http.Client httpClient;
//
//   StockApiClient({required this.httpClient}) : assert(httpClient != null);
//
//   Future<StockModel> fetchStockInformation(String stockSymbol) async {
//     var searchString = trimAndUppercaseString(stockSymbol);
//     final apiRequestUrl =
//         '$baseUrl/api/v1/quote?symbol=$searchString&token=$apiKey';
//     final apiResponse = await httpClient.get(Uri.parse(apiRequestUrl));
//     if (apiResponse.statusCode != 200) {
//       throw Exception('Error in StockApiClient.fetchStockInformation() ' +
//           apiResponse.toString());
//     }
//     final apiResponseJson = jsonDecode(apiResponse.body);
//     return StockModel.generateModel(searchString, apiResponseJson);
//   }
// }
