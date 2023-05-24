class DefaultWPErrorData {

  final int? status;
  final Map<String, dynamic>? params;
  final Map<String, dynamic>? details;

  DefaultWPErrorData({this.status, this.params, this.details});

  factory DefaultWPErrorData.fromJson(Map<String, dynamic> json) {
    return DefaultWPErrorData(
      status: json['status'],
      params: json['params'],
      details: json['details']
    );
  }
}