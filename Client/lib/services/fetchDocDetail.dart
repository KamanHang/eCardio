import 'dart:async';
import 'dart:convert';

import 'package:ecardio/model/DocDetails.dart';
import 'package:ecardio/model/PatientDetails.dart'; // Import your PatientDetails class
import 'package:ecardio/services/ip_address.dart';
import 'package:http/http.dart' as http;

class DocDetailsService {
  static Future<List<DocModel>?> fetchDetailsByID(int docID) async {
    try {
      // Replace this URL with the actual endpoint to fetch patient details
      var url = Uri.parse("http://${newIP()}:3000/doctordetails");

      var response = await http.post(url, body: {'docID': docID.toString()});
      
      if (response.statusCode == 200) {
        // Parse the response and return a list of PatientDetails objects
        // Replace this with the actual structure of your response
        var data = jsonDecode(response.body.toString());
        List<DocModel> docDetails = [];
        for (Map<String, dynamic> index in data) {
          docDetails.add(DocModel.fromJson(index));
        }
        
        print("Doc details fetched successfully.");
        print(response.body);

        return docDetails;
      } else {
        // Handle error cases
        print('Failed to fetch Doc details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error fetching Doc details: $e');
    }
    return null;
  }
}
