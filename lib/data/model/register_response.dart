class RegisterResponse {
  int statusCode;
  String message;
  String? errorMessage;

  RegisterResponse({
    required this.statusCode,
    required this.message,
    required this.errorMessage,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      errorMessage: json['errorMessage'],
      statusCode: json['statusCode'],
    );
  }
}
