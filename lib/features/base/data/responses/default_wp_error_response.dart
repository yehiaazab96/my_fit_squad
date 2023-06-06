import 'default_wp_error_data.dart';

class DefaultErrorResponse {
  final String? code;
  final String? error;
  final DefaultWPErrorData? data;

  DefaultErrorResponse({this.code, this.error, this.data});

  factory DefaultErrorResponse.fromJson(Map<String, dynamic> json) {
    return DefaultErrorResponse(
        code: json['code'],
        error: json['error'],
        data: json['data'] == null
            ? null
            : DefaultWPErrorData.fromJson(json['data']));
  }
}
