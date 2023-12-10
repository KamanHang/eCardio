import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

//created a class
class RegisterService {
//parsed database url

  static Future<String?> signUp({
    //creating essential variable
    required String patient_id,
    required String first_name,
    required String last_name,
    required String phone_number,
    required String email,
    required String password,
    required File imagePath
  }) async {
    try {
      var url = Uri.parse('http://192.168.17.198:3000/signup');

      var response = await http.post(url, body: {
        'patient_id': patient_id,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'password': password,
        'imagePath': imagePath
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Check Internet Connection');
      });
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
