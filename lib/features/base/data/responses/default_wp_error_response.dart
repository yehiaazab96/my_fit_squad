
import 'default_wp_error_data.dart';

class DefaultWPErrorResponse {
  final String? code;
  final String? message;
  final DefaultWPErrorData? data;

  DefaultWPErrorResponse({this.code, this.message, this.data});

  factory DefaultWPErrorResponse.fromJson(Map<String, dynamic> json) {

    return DefaultWPErrorResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'] == null ? null : DefaultWPErrorData.fromJson(json['data'])
    );
  }
}
