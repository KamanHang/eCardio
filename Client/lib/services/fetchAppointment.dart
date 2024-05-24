import 'dart:async';
import 'dart:convert';

import 'package:ecardio/model/Appointment.dart';
import 'package:ecardio/model/DocDetails.dart';
import 'package:ecardio/model/PatientDetails.dart'; // Import your PatientDetails class
import 'package:ecardio/services/ip_address.dart';
import 'package:http/http.dart' as http;

class AppointmentDetailsService {
  static Future<List<AppointmentModel>?> fetchDetailsByID(int patientId) async {
    try {
      // Replace this URL with the actual endpoint to fetch patient details
      var url = Uri.parse("http://${newIP()}:3000/fetchappointment");

      var response = await http.post(url, body: {'patient_id': patientId.toString()});
      
      if (response.statusCode == 200) {
        // Parse the response and return a list of PatientDetails objects
        // Replace this with the actual structure of your response
        var data = jsonDecode(response.body.toString());
        List<AppointmentModel> appointmentDetails = [];
        for (Map<String, dynamic> index in data) {
          appointmentDetails.add(AppointmentModel.fromJson(index));
        }
        
        print("Appointment details fetched successfully.");
        print(response.body);

        return appointmentDetails;
      } else {
        // Handle error cases
        print('Failed to fetch Appointment details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error fetching Appointment details: $e');
    }
    return null;
  }
}
