import 'package:ecardio/model/DocDetails.dart';
import 'package:ecardio/services/fetchDocDetail.dart';
import 'package:flutter/foundation.dart';

class DocProvider extends ChangeNotifier {
  DocModel? _docDetails;

  DocModel? get docDetails => _docDetails;

  // Method to fetch patient details
  Future<void> fetchDoctorDetails(int docID) async {
  try {
    List<DocModel>? details = await DocDetailsService.fetchDetailsByID(docID);
    print(docID);

    if (details != null && details.isNotEmpty) {
      _docDetails = details.first;
      notifyListeners();
      print('Doc details set in the provider: $_docDetails');
    } else {
      print('Doc details not available.');
    }
  } catch (e) {
    print('Error fetching Doc details: $e');
  }
}

}
