import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../injection/injection_container.dart' as di;
// import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/constants.dart';
import 'api_urls.dart';

const String doNotInterceptKey = "do_not_intercept";
const String authorizationRequired = "authorization_required";

class ApiConfig {
  static Dio dio = createDio();

  static final Dio _refreshDio = Dio(BaseOptions(
      connectTimeout: 10000, receiveTimeout: 10000, baseUrl: ApiUrls.baseUrl));

  static DioCacheManager dioCacheManager = DioCacheManager(CacheConfig(
    baseUrl: ApiUrls.baseUrl,
    defaultMaxStale: const Duration(days: 2),
    defaultMaxAge: const Duration(days: 0),
  ));

  static Dio createDio() {
    var dio = Dio(BaseOptions(
        connectTimeout: 10000, receiveTimeout: 10000, baseUrl: ApiUrls.baseUrl))
      ..interceptors.addAll([AppInterceptor(), dioCacheManager.interceptor]);
    // if (kIsWeb) {}
    return dio;
  }
}

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!(options.extra[doNotInterceptKey] ?? false)) {
      print('on request');

      String baseUrl = ApiUrls.baseUrl;
      // String consumerKey = ApiUrls.consumerKey;
      // String consumerSecret = ApiUrls.consumerSecret;

      if (baseUrl.endsWith('/')) {
        baseUrl = baseUrl.substring(0, baseUrl.length - 1);
      }
      options.path = '$baseUrl${options.path}';
      if (options.extra.containsKey(authorizationRequired) &&
          (options.extra[authorizationRequired] as bool)) {
        options.headers['Authorization'] = 'Bearer $_token';
      }
      // if (options.extra.containsKey(wpApiKey) &&
      //     (options.extra[wpApiKey] as bool)) {
      //   options.path =
      //       '${options.path}?consumer_secret=$consumerSecret&consumer_key=$consumerKey';
      // }
    }

    print(options.uri.toString());
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    print('on error ${err.type.toString()}');
    if (err.error is SocketException) {
      err.type = DioErrorType.connectTimeout;
    }
    await handleApiError(ApiConfig.dio, err, handler);

    super.onError(err, handler);
  }

  Future<void> handleApiError(Dio requesterDio, DioError dioError,
      ErrorInterceptorHandler handler) async {
    print('on error ${dioError.type.toString()}');
    var dontIntercept =
        dioError.response?.requestOptions.extra[doNotInterceptKey] ?? false;
    if (dioError.type == DioErrorType.response) {
      if (dioError.response?.statusCode == validationError &&
          dioError.requestOptions.headers.containsKey('Authorization')) {
        // if (!dontIntercept) {
        //   await _refreshExpiredToken(requesterDio, dioError, handler);
        // } else {
        //   handler.reject(dioError);
        // }
        handler.reject(dioError);

        return;
      }
    } else if (dioError.error is SocketException) {
      dioError.type = DioErrorType.connectTimeout;
    } else if (dioError.error is HandshakeException) {
      dioError.type = DioErrorType.connectTimeout;
    }
  }

  static String get _token =>
      ProviderScope.containerOf(Constants.navigatorKey.currentContext!,
              listen: false)
          .read(di.userProvider)!
          .accessToken ??
      '';
}
