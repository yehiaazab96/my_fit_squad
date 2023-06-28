import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/models/base_list_response.dart';
import 'package:my_fit_squad/features/base/data/models/base_response.dart';
import 'package:my_fit_squad/features/base/data/responses/default_wp_error_response.dart';

import 'api_config.dart';

class ApiMethods<T> {
  Future<BaseApiResult<T>> get(String url,
      {Map<String, dynamic>? params,
      bool hasToken = true,
      bool cache = false,
      bool isWPApi = true}) async {
    try {
      Response response = await ApiConfig.dio.get(url,
          queryParameters: params,
          options:
              getOptions(cache: cache, hasToken: hasToken, isWPApi: isWPApi));
      print(response.toString());
      return _handleResponse(response);
    } on DioError catch (error) {
      print(error);
      return _catchError<T>(error);
    }
  }

  // Future<List> basicGetList(String url,
  //     {Map<String, dynamic>? params,
  //     bool hasToken = true,
  //     bool cache = false,
  //     bool isWPApi = true}) async {
  //   try {
  //     Response response = await ApiConfig.dio.get(url,
  //         queryParameters: params,
  //         options:
  //             getOptions(cache: cache, hasToken: hasToken, isWPApi: isWPApi));
  //     print(response.toString());
  //     return _handleResponse(response);
  //   } on DioError catch (error) {
  //     print(error);
  //     return _catchError<T>(error);
  //   }
  // }

  Future<BaseApiResult<List<T>>> getList(String url,
      {Map<String, dynamic>? params,
      bool hasToken = true,
      bool cache = false,
      bool isWPApi = false}) async {
    try {
      print(params);
      Response response = await ApiConfig.dio.get(url,
          queryParameters: params,
          options:
              getOptions(cache: cache, hasToken: hasToken, isWPApi: isWPApi));
      print(response.toString());
      return _handleResponseList(response);
    } on DioError catch (error) {
      return _catchError<List<T>>(error);
    }
  }

  Future<BaseApiResult<T>> post(String url,
      {Map<String, dynamic>? data,
      bool hasToken = true,
      bool cache = false,
      bool isWPApi = false}) async {
    try {
      print('${data.toString()}');
      Response response = await ApiConfig.dio.post(url,
          data: data,
          options:
              getOptions(cache: cache, hasToken: hasToken, isWPApi: isWPApi));

      print('${response.toString()}');
      return _handleResponse(response);
    } on DioError catch (error) {
      print(error);
      return _catchError(error);
    }
  }

  Future<BaseApiResult<List<T>>> postList(String url,
      {Map<String, dynamic>? data,
      bool hasToken = true,
      bool cache = false,
      bool isWPApi = false}) async {
    try {
      print('${data.toString()}');
      Response response = await ApiConfig.dio.post(url,
          data: data,
          options:
              getOptions(cache: cache, hasToken: hasToken, isWPApi: isWPApi));

      print('${response.toString()}');
      return _handleResponseList(response);
    } on DioError catch (error) {
      print(error);
      return _catchError(error);
    }
  }

  Future<BaseApiResult<T>> put(String url,
      {Map<String, dynamic>? data,
      bool hasToken = true,
      bool cache = false,
      bool isWPApi = false}) async {
    try {
      print('${data.toString()}');
      Response response = await ApiConfig.dio.put(url,
          data: data,
          options:
              getOptions(cache: cache, hasToken: hasToken, isWPApi: isWPApi));

      print('${response.toString()}');
      return _handleResponse(response);
    } on DioError catch (error) {
      print(error);
      return _catchError(error);
    }
  }

  Future<BaseApiResult<T>> delete(String url,
      {Map<String, dynamic>? data,
      bool hasToken = true,
      bool cache = false,
      bool isWPApi = false}) async {
    try {
      print('${data.toString()}');
      Response response = await ApiConfig.dio.delete(url,
          data: data,
          options:
              getOptions(cache: cache, hasToken: hasToken, isWPApi: isWPApi));

      print('${response.toString()}');
      return _handleResponse(response);
    } on DioError catch (error) {
      print(error);
      return _catchError(error);
    }
  }

  Future<BaseApiResult<T>> postWithFormData(String url,
      {required FormData data,
      bool hasToken = true,
      bool cache = false,
      bool isWPApi = false}) async {
    try {
      Response response = await ApiConfig.dio.post(url,
          data: data,
          options:
              getOptions(cache: cache, hasToken: hasToken, isWPApi: isWPApi));

      print(response.toString());
      return _handleResponse(response);
    } on DioError catch (error) {
      print(error);
      return _catchError(error);
    }
  }

  Options getOptions(
      {bool cache = false, bool hasToken = true, bool isWPApi = false}) {
    Map<String, dynamic> extras = {};
    extras[authorizationRequired] = hasToken;
    var options = Options(
        followRedirects: false,
        validateStatus: (status) => true,
        extra: extras,
        headers: hasToken
            ? {
                'Authorization':
                    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2M2RmMTYzNThkNzEwNDdmYzRkZjZkYzYiLCJpYXQiOjE2ODUyMDg2NDgsImV4cCI6MTY4NTQ2Nzg0OH0.cjm8yjLH2NOJxJnxpZGNf-r3qjrXIOFDNnGNkIkgimk'
              }
            : {});
    return cache
        ? buildCacheOptions(const Duration(minutes: 3),
            maxStale: const Duration(minutes: 7),
            options: options,
            forceRefresh: true)
        : options;
  }

  BaseApiResult<List<T>> _handleResponseList(Response response) {
    var responseData = response.data;
    if (responseData == null) {
      return BaseApiResult<List<T>>(errorType: ApiErrorType.generalError);
    }
    BaseListResponse<T> baseResponse =
        BaseListResponse<T>.fromJson(responseData);
    return BaseApiResult<List<T>>(data: baseResponse.data);
  }

  BaseApiResult<T> _handleResponse(Response response) {
    var responseData = response.data;

    if (responseData == null) {
      return BaseApiResult<T>(errorType: ApiErrorType.generalError);
    }
    BaseResponse<T> baseResponse = BaseResponse<T>.fromJson(responseData);
    return BaseApiResult<T>(
        data: baseResponse.data, successMessage: baseResponse.successMessage);
  }

  BaseApiResult<E> _catchError<E>(DioError dioError) {
    if (dioError.type == DioErrorType.response) {
      return _handleApiErrors(dioError);
    } else {
      return _handleDioErrors(dioError);
    }
  }

  BaseApiResult<E> _handleDioErrors<E>(DioError dioError) {
    if (dioError.type == DioErrorType.connectTimeout) {
      return BaseApiResult<E>(errorType: ApiErrorType.noNetworkError);
    } else if (dioError.type == DioErrorType.receiveTimeout) {
      return BaseApiResult<E>(errorType: ApiErrorType.noNetworkError);
    } else if (dioError.type == DioErrorType.sendTimeout) {
      return BaseApiResult<E>(errorType: ApiErrorType.noNetworkError);
    } else if (dioError.type == DioErrorType.cancel) {
      return BaseApiResult<E>(errorType: ApiErrorType.generalError);
    } else if (dioError.type == DioErrorType.other) {
      return BaseApiResult<E>(errorType: ApiErrorType.generalError);
    } else {
      return BaseApiResult<E>(errorType: ApiErrorType.generalError);
    }
  }

  BaseApiResult<E> _handleApiErrors<E>(DioError dioError) {
    print(dioError.response.toString());
    var responseData = dioError.response?.data;
    if (responseData == null) {
      return BaseApiResult<E>(errorType: ApiErrorType.generalError);
    } else if ((responseData is Map<String, dynamic>)) {
      DefaultErrorResponse baseResponse =
          DefaultErrorResponse.fromJson(responseData);
      print(dioError.response?.statusCode.toString());
      switch (dioError.response?.statusCode) {
        case unauthorizedError:
          print(baseResponse.error);
          return BaseApiResult<E>(
              errorType: ApiErrorType.unauthorizedError,
              errorMessage: baseResponse.error,
              apiErrors: baseResponse);
        case validationError:
          return BaseApiResult<E>(
              errorType: ApiErrorType.validationError,
              errorMessage: baseResponse.error,
              apiErrors: baseResponse);
        case notFound:
          return BaseApiResult<E>(
              errorMessage: baseResponse.error, apiErrors: baseResponse);
        case badRequestError:
          return BaseApiResult<E>(
              errorMessage: baseResponse.error, apiErrors: baseResponse);
        case serverError:
          return BaseApiResult<E>(errorType: ApiErrorType.generalError);
        default:
          return BaseApiResult<E>(errorType: ApiErrorType.generalError);
      }
    }
    return BaseApiResult<E>(errorType: ApiErrorType.generalError);
  }
}
