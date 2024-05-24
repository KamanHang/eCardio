import 'dart:async';

import 'package:ecardio/services/ip_address.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Providers/AuthProvider.dart';

class LoginStudent extends ChangeNotifier {
  final AuthProvider authProvider;

  LoginStudent(this.authProvider);

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      var url = Uri.parse("http://${newIP()}:3000/login");

      print(url);

      var response = await http.post(url, body: {'email': email, 'password': password}).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('Check Internet Connection');
        },
      );

      if (response.statusCode == 200) {
        authProvider.login(email);
      } else if (response.statusCode == 400) {
        print(response.body);
      } else {
        // Handle other status codes if needed
      }
    } catch (e) {
      print(e);
    }
  }
}
