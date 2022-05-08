import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  DioClient(
    this.baseUrl,
    Dio? dio, {
    this.interceptors,
  }) {
    _dio = dio ?? Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          requestHeader: false,
          responseHeader: false,
          request: false));
    }
  }
  final String baseUrl;

  late Dio _dio;

  final List<Interceptor>? interceptors;

  Future<dynamic> get(
    String uri, {
    required Map<String, dynamic> queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      // await FirebaseCrashlytics.instance.log(e.toString());
      // await FirebaseCrashlytics.instance
      //     .recordFlutterError(FlutterErrorDetails(exception: e));
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      // await FirebaseCrashlytics.instance.log(e.toString());
      // await FirebaseCrashlytics.instance
      //     .recordFlutterError(FlutterErrorDetails(exception: e));
      throw const FormatException('Unable to process the data');
    } catch (e) {
      await FirebaseCrashlytics.instance.log(e.toString());
      await FirebaseCrashlytics.instance
          .recordFlutterError(FlutterErrorDetails(exception: e));
      rethrow;
    }
  }
}
