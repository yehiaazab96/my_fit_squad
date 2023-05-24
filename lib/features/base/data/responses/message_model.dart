class MessageModel {
  String? messgae;
  MessageModel({
    this.messgae,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    messgae = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messgae'] = this.messgae;
    return data;
  }
}
