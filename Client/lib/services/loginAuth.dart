import 'dart:async';

import 'package:ecardio/services/ipPort.dart';
import 'package:http/http.dart' as http;

class LoginStudent {
  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      var url = Uri.parse("http://192.168.1.80:3000/login");

      print(url);

      var response = await http
          .post(url, body: {'email': email, 'password': password}).timeout(
              const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('Check Internet Connection');
      });
      if (response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      print(e);
    }
    return null;
  
  }
}
