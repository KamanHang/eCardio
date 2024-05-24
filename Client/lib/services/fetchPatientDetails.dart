import 'dart:async';
import 'dart:convert';

import 'package:ecardio/model/PatientDetails.dart'; // Import your PatientDetails class
import 'package:ecardio/services/ip_address.dart';
import 'package:http/http.dart' as http;

class PatientDetailsService {
  static Future<List<PatientDetails>?> fetchDetailsByEmail(String email) async {
    try {
      // Replace this URL with the actual endpoint to fetch patient details
      var url = Uri.parse("http://${newIP()}:3000/patientdetails");

      var response = await http.post(url, body: {'email': email});
      
      if (response.statusCode == 200) {
        // Parse the response and return a list of PatientDetails objects
        // Replace this with the actual structure of your response
        var data = jsonDecode(response.body.toString());
        List<PatientDetails> patientDetails = [];
        for (Map<String, dynamic> index in data) {
          patientDetails.add(PatientDetails.fromJson(index));
        }
        
        print("Patient details fetched successfully.");
        print(response.body);

        return patientDetails;
      } else {
        // Handle error cases
        print('Failed to fetch patient details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error fetching patient details: $e');
    }
    return null;
  }
}
