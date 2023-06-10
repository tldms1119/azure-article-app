class ResponseModel {
  final bool result;
  final String message;

  ResponseModel.fromJson(Map<String, dynamic> json)
      : result = json['result'],
        message = json['message'];
}
