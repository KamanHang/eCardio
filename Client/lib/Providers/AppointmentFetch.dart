import 'package:ecardio/model/Appointment.dart';
import 'package:ecardio/services/fetchAppointment.dart';
import 'package:flutter/foundation.dart';
import 'package:ecardio/model/PatientDetails.dart'; // Import your PatientDetails class
import 'package:ecardio/services/fetchPatientDetails.dart'; // Import your service for fetching patient details

class AppointmentProvider extends ChangeNotifier {
  AppointmentModel? _appointmentDetails;

  AppointmentModel? get patientDetails => _appointmentDetails;

  // Method to fetch patient details
  Future<void> fetchAppointmentDetails(int patientId) async {
  try {
    List<AppointmentModel>? details = await  AppointmentDetailsService.fetchDetailsByID(patientId);

    if (details != null && details.isNotEmpty) {
      _appointmentDetails = details.first;
      notifyListeners();
      print('Patient details set in the provider: $_appointmentDetails');
    } else {
      print('Patient details not available.');
    }
  } catch (e) {
    print('Error fetching patient details: $e');
  }
}

}
