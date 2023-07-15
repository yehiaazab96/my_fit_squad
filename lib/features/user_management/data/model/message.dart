class ResponseMessage {
  String? message;

  ResponseMessage({
    this.message,
  });

  ResponseMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
