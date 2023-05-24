import 'package:my_fit_squad/common/api/api_error_type.dart';

class BaseApiResult<T> {
  int? status;
  T? data;
  final ApiErrorType? errorType;
  final String? successMessage;
  final String? errorMessage;
  final dynamic apiErrors;

  BaseApiResult(
      {this.data,
      this.status,
      this.errorType,
      this.successMessage,
      this.errorMessage,
      this.apiErrors});
}
