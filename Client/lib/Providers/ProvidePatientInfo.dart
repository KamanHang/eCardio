import 'package:flutter/foundation.dart';
import 'package:ecardio/model/PatientDetails.dart'; // Import your PatientDetails class
import 'package:ecardio/services/fetchPatientDetails.dart'; // Import your service for fetching patient details

class PatientProvider extends ChangeNotifier {
  PatientDetails? _patientDetails;

  PatientDetails? get patientDetails => _patientDetails;

  // Method to fetch patient details
  Future<void> fetchPatientDetails(String userEmail) async {
  try {
    List<PatientDetails>? details = await PatientDetailsService.fetchDetailsByEmail(userEmail);

    if (details != null && details.isNotEmpty) {
      _patientDetails = details.first;
      notifyListeners();
      print('Patient details set in the provider: $_patientDetails');
    } else {
      print('Patient details not available.');
    }
  } catch (e) {
    print('Error fetching patient details: $e');
  }
}

}
