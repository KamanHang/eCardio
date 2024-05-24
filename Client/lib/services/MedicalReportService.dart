import 'dart:async';
import 'dart:convert';
import 'package:ecardio/model/MedicalReport.dart';
import 'package:http/http.dart' as http;
import 'package:ecardio/services/ip_address.dart';

class MedicalReportService {
  static Future<List<MedicalReportModel>?> fetchReportsByPatientId(
      int patientId) async {
        print(patientId);
    try {
      var url = Uri.parse(
          "http://${newIP()}:3000/getmedicaldata"); // Replace with the actual endpoint

      var response = await http.post(url, body: {'patient_id': patientId.toString()});

      print(response);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        List<MedicalReportModel> medicalReports = [];
        for (Map<String, dynamic> index in data) {
          medicalReports.add(MedicalReportModel.fromJson(index));
        }

        print("Medical reports fetched successfully.");
        print(response.body);

        return medicalReports;
      } else {
        print(
            'Failed to fetch medical reports. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching medical reports: $e');
    }
    return null;
  }
}
