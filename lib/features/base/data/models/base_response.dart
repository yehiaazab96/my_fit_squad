import 'package:my_fit_squad/features/base/data/helpers/json_parser.dart';

class BaseResponse<T> {
  final T? data;
  final String? successMessage;

  BaseResponse({this.data, this.successMessage});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(data: json.parse<T>(), successMessage: json["message"]);
  }
}
