import 'package:http/http.dart';
import 'dart:convert';



class LoginService {
  final Client _http;
  LoginService(this._http);

  static final _headers = {'Content-Type': 'application/json'};
  static final String baseUrl = 'http://localhost:8000/users/';

  Future<String> login(String username, String password) async {
    try {
      final response = await _http.post(baseUrl + "get-token", body: {"username": username, "password": password});
      var clean = _extractData(response);
      return clean['token'];
    }catch (e) {
      return null;
    }
  }
  dynamic _extractData(Response resp) => json.decode(resp.body);
}
