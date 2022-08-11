import 'dart:async';
import '../main.dart';
import '../routes.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import '../../routes.dart';
import 'endpoints.dart';


class RestClient {
  Dio _dio;

  static final RestClient _client = RestClient._internal();

  factory RestClient() => _client;

  RestClient._internal() {
    _dio = new Dio();
    _dio.options.baseUrl = Endpoints.server;
    _dio.options.connectTimeout = 20000;
    _dio.options.receiveTimeout = 10000;
    _dio.transformer = FlutterTransformer();
    _dio.interceptors.add(EnvironmentManager());
    _dio.interceptors.add(SessionManager());
  }

  Future<dynamic> get(String url, {Map<String, dynamic> match = const {}}) async
  {
    try {
      final response = await _dio.get(url, queryParameters: match);
      return response.data;
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        await navigatorKey.currentState.pushNamedAndRemoveUntil(Routes.splash, (route) => false);
      }
      return throw e;
    }
  }
}

class EnvironmentManager extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    options.baseUrl = Endpoints.server;
  }
}

class SessionManager extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    options.headers['X-Api-Key'] = Endpoints.APIkey;
  }
}