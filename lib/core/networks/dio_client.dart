import 'package:bookly/data/datasources/remote/book_api_service.dart';
import 'package:dio/dio.dart';
import 'package:bookly/core/configs/env_config.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';


class DioClient {
  static const String tag = 'WebService-bookly';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;
  static String baseUrl = "https://www.googleapis.com/books/v1";

  DioException? dioError;
  static DioClient? appDioService;
  static BookApiService? bookApiService;


  static Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Cache-Control': 'no-cache',
    },
    connectTimeout: const Duration(milliseconds: connectTimeout),
    receiveTimeout: const Duration(milliseconds: receiveTimeout),
    sendTimeout: const Duration(milliseconds: sendTimeout),
  ));

  static DioClient getInstance() {
    appDioService ??= DioClient._();
    return appDioService!;
  }

  static BookApiService getBookApiService() {
    if (bookApiService == null) {
      DioClient.getInstance();
      bookApiService = BookApiService(dio, baseUrl: baseUrl);
    }
    return bookApiService!;
  }



  DioClient._() {
    _initializeService();
  }

  void _initializeService() {
    addInterceptor();
  }

  void addInterceptor() {
    dio.interceptors.clear();

    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
    }

    dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
            options.queryParameters['key'] = EnvConfig().bookApiKey;
            return handler.next(options);
      },
      onResponse: (Response<dynamic> response,
          ResponseInterceptorHandler handler) async {
        if (response.data == null) {
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: 'Réponse vide',
              type: DioExceptionType.badResponse,
            ),
          );
        }
        return handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        debugPrint("Error interceptor webservice: ${e.response}");
        return handler.next(e);
      },
    ));
  }

}