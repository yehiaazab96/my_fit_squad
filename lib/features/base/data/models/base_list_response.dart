import 'package:my_fit_squad/features/base/data/helpers/json_parser.dart';

class BaseListResponse<T> {
  final List<T>? data;

  BaseListResponse({this.data});

  factory BaseListResponse.fromJson(List json) {
    List<T>? dataList;
    dataList = (json)
        .map((i) => (i as Map<String, dynamic>).parse<T>())
        .whereType<T>()
        .toList();

    return BaseListResponse(data: dataList);
  }
}
