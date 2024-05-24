import 'dart:async';

import 'package:ecardio/services/ip_address.dart';
import 'package:http/http.dart' as http;

//created a class
class BookService {
//parsed database url

  static Future<String?> book({
    //creating essential variable
    required String appointment_type,
    required String appointment_date,
    required String appointment_time,
    required int? patient_id,
    required int? doctor_id,
    required String week_day,
    required String patient_name,
    required String doctor_name,
    required String patientEmail,

  }) async {
    try {
      var url = Uri.parse('http://${newIP()}:3000/bookAppointment');

      var response = await http.post(url, body: {
        "appointment_type": appointment_type,
        "appointment_date": appointment_date,
        "appointment_time": appointment_time,
        "patient_id": patient_id.toString(),
        "doctor_id": doctor_id.toString(),
        "week_day": week_day,
        "patient_name": patient_name,
        "doctor_name": doctor_name,
        "patientEmail": patientEmail,

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
