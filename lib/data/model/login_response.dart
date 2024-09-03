class LoginResponse {
  int statusCode;
  String message;
  String? errorMessage;
  Data? data;

  LoginResponse({
    required this.statusCode,
    required this.message,
    required this.errorMessage,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      errorMessage: json['errorMessage'],
      statusCode: json['statusCode'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  String token;

  Data({
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
    );
  }
}
