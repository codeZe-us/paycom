import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService {
  ApiService._();

  static Dio _init() {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: "https://paycom.com.ng",
      connectTimeout: const Duration(seconds: 20),
      responseType: ResponseType.json,
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 40),
    // headers: {"Content-Type": "multipart/form-data", "accept": "application/json"},
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          log(options.headers.toString());
          log(options.baseUrl + options.path);
          log(options.data.toString());
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          log(response.data.toString());
          log(response.toString());
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          log(e.response.toString());
          log(e.error.toString());
          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  static Future<Response> _post(String path, FormData body) {
    return _init().post(path, data: body);
  }

  static Future<Response> registerUser(FormData body) {
    return _post("/api/registration", body);
  }

  static Future<Response> loginUser(FormData body) {
    log(body.fields.toString());
    return _post("/api/login", body);
  }
}
