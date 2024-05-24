import 'dart:async';
import 'dart:convert'; // Import for JSON decoding
import 'dart:io';
import 'package:ecardio/services/ip_address.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AnalyzeData extends StatefulWidget {
  const AnalyzeData({Key? key}) : super(key: key);

  @override
  State<AnalyzeData> createState() => _AnalyzeDataState();
}

class _AnalyzeDataState extends State<AnalyzeData> {
  File? selectedImage;

  String predictedOutput = "";

  Future pickImageGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      selectedImage = File(pickedImage.path);
    });
  }

  Future<void> analyzeImage() async {
    if (selectedImage == null) {
      return;
    }

    final uri = Uri.parse('http://${newIP()}:4000/');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('imagefile', selectedImage!.path));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final jsonResponse = json.decode(response.body); // Parse the JSON response
      final message = jsonResponse['message']; // Extract the message from the JSON

      setState(() {
        predictedOutput = message; // Update the predicted message state
      });
      print(response.body);
    } catch (e) {
      print(e);
      setState(() {
        predictedOutput = 'Error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedImage != null
                ? Image.file(
                    selectedImage!,
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : const Image(
                    image: AssetImage('assets/images/Aanalyze.png'),
                    width: 350,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
            ElevatedButton.icon(
              style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Color(0xFF34A77F)),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15)),
                          shape:
                              MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ))),
              onPressed: pickImageGallery,
              label: const Text("Upload your ECG Image",style: TextStyle(color: Colors.white),),
              icon: const Icon(Iconsax.document_upload, color: Colors.white),

            ),
            const SizedBox(height: 10,),
            ElevatedButton.icon(
              icon: const Icon(Iconsax.chart_1, color: Colors.white),
               style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Color(0xFF34A77F)),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15)),
                          shape:
                              MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ))),
              onPressed: analyzeImage,
              label: const Text('Analyze', style: TextStyle(color: Colors.white),),
            ),
            Text(predictedOutput, style: TextStyle(color: Colors.black),)
          ],
        ),
      ),
    );
  }
}
