import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecardio/Providers/ProvidePatientInfo.dart';
import 'package:ecardio/model/PatientDetails.dart';
import 'package:ecardio/services/ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class MedicalReportPage extends StatefulWidget {
  const MedicalReportPage({Key? key}) : super(key: key);

  @override
  State<MedicalReportPage> createState() => _MedicalReportPageState();
}

class _MedicalReportPageState extends State<MedicalReportPage> {
  PatientDetails? patientDetails;
  int? patient_id;

  File? selectedImage;
  String pickedImagePath = "";
  String recognizedTextFromImage = "";
  String reportOutput = "";
  String selectedReportType = "Liver-Test-Report";
  final List<String> reportTypes = [
    "Liver-Test-Report",
    "Blood Test Report",
    "Coagulation Test",
  ];

  String tableDataJsonString = '';
  String liverResult = '';

  Future pickImageGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      selectedImage = File(pickedImage.path);
      pickedImagePath = pickedImage.path;
      recognizedTextFromImage = "";
    });
  }

  Future<void> performTextRecognition() async {
    if (selectedImage == null) {
      return;
    }

    final inputImage = InputImage.fromFilePath(pickedImagePath);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      recognizedTextFromImage = recognizedText.text;
      var jsonData = buildDataRowList(recognizedTextFromImage);
      tableDataJsonString = json.encode(jsonData);
     
    });
  }

  List<Map<String, dynamic>> buildDataRowList(String text) {
    List<String> sections = text.split('\n\n');
    List<Map<String, dynamic>> jsonData = [];

    for (String section in sections) {
      List<String> lines = section.split('\n');
      if (lines.length <= 1) continue;
      String category = lines.first;
      List<String> categoryData = lines.sublist(1);

      if (categoryData.length < 21) {
        print("Invalid category data for category: $category");
        continue;
      }

      for (int i = 0; i < 7; i++) {
        String testName = categoryData[i];
        String value = categoryData[i + 7];
        String referenceRange = categoryData[i + 14];

        Map<String, dynamic> rowData = {
          'Test': testName,
          'Result': value,
          'Ref Range': referenceRange,
        };
        jsonData.add(rowData);
      }
    }

    return jsonData;
  }

  String checkBillirubin() {
     
    if (tableDataJsonString.isNotEmpty) {
      List<Map<String, dynamic>> jsonData = json
          .decode(tableDataJsonString)
          .cast<Map<String, dynamic>>();
      for (var data in jsonData) {
        String testType = data['Test'];
        double result = double.parse(data['Result']);
        if (testType == 'Total Billirubin' && result > 1.1) {
          liverResult = "High Jaundice";
          print('High Jaundice');
          print("Lol");
      print(tableDataJsonString);
        } else if (testType == 'Total Billirubin' && result < 0.1) {
          liverResult = "Low Bilirubin";
        }
      }
    }
    return liverResult;
  }

  void analyzeReport() async {
    if (selectedImage == null) {
      return;
    }

    final inputImage = InputImage.fromFilePath(pickedImagePath);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      recognizedTextFromImage = recognizedText.text;
      checkBillirubin();
      showDietCards = true;
    });
  }

  bool showDietCards = false;

  Future<void> sendDataToApi(String jsonData) async {
    String currentDate = DateTime.now().toString().substring(0, 10);

    List<Map<String, dynamic>> jsonDataList =
        json.decode(jsonData).cast<Map<String, dynamic>>();

    for (var data in jsonDataList) {
      Map<String, dynamic> dataToSend = {
        'patient_id': patient_id,
        'ReportDate': currentDate,
        'Test': data['Test'],
        'Result': data['Result'],
        'RefRange': data['Ref Range'],
      };

      String postData = json.encode(dataToSend);

      print(postData);

      String apiUrl = 'http://${newIP()}:3000/savemedicaldata';

      try {
        var response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: postData,
        );

        if (response.statusCode == 200) {
          print('Data sent successfully for ${data["Test"]}');
        } else {
          print(
              'Failed to send data for ${data["Test"]}. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error sending data for ${data["Test"]}: $error');
      }
    }
  }

  void sendData() {
    sendDataToApi(tableDataJsonString);
  }

  Widget build(BuildContext context) {

    final patientProvider = Provider.of<PatientProvider>(context);
    patientDetails = patientProvider.patientDetails;
    patient_id = patientDetails!.patientId;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Report"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Report Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedReportType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedReportType = newValue!;
                      });
                    },
                    items: reportTypes.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
              SizedBox(height: 50),
              selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/medicalreport.png',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: pickImageGallery,
                icon: Icon(Iconsax.document_upload, color: Colors.white),
                label: Text(
                  "Upload Medical Report",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF34A77F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: performTextRecognition,
                icon: Icon(FontAwesomeIcons.eye, color: Colors.white),
                label: Text(
                  'Extract',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF34A77F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey[200]!),
                      columns: [
                        DataColumn(label: Text('Test')),
                        DataColumn(label: Text('Result')),
                        DataColumn(label: Text('Ref Range')),
                      ],
                      rows: buildDataRowList(recognizedTextFromImage)
                          .map<DataRow>((dataRow) {
                        return DataRow(
                          cells: [
                            DataCell(Text(dataRow['Test']!)),
                            DataCell(Text(dataRow['Result']!)),
                            DataCell(Text(dataRow['Ref Range']!)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: analyzeReport,
                    icon: Icon(FontAwesomeIcons.microchip, color: Colors.white),
                    label: Text(
                      'Analyze',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF34A77F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton.icon(
                    onPressed: sendData,
                    icon: Icon(Icons.save, color: Colors.white),
                    label: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF34A77F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(liverResult),
              SizedBox(height: 20),
              showDietCards ? buildDietCardsSection() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDietCardsSection() {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reportOutput,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                buildDietCard('Breakfast', 'assets/images/Breakfast.png'),
              ],
            ),
          ),
          SizedBox(width: 20), 
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: buildDietCard('Lunch', 'assets/images/Lunch.png'),
          ),
          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: buildDietCard('Dinner', 'assets/images/Dinner.png'),
          ),
        ],
      ),
    );
  }

  Widget buildDietCard(String workoutName, String imagePath) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                scale: 10,
              ),
            ),
            SizedBox(height: 5),
            Text(
              workoutName,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
