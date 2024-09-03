import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:to_do_list/data/model/login_response.dart';
import 'package:to_do_list/data/model/register_response.dart';

class ApiService {
  static const String _baseUrl = "http://94.74.86.174:8080/api";

  Future<LoginResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      body: jsonEncode(<String, String>{
        'username': "fahrul1",
        'password': "123456",
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    return LoginResponse.fromJson(json.decode(response.body));
  }

  Future<RegisterResponse> register(
      String email, String username, String password) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/register"),
      body: jsonEncode(<String, String>{
        "email": email,
        "username": username,
        "password": password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    return RegisterResponse.fromJson(json.decode(response.body));
  }
}
