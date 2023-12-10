import 'dart:convert';

import 'package:ecardio/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Doctor extends StatefulWidget {

  
  const Doctor({super.key});


  @override
  State<Doctor> createState() => _DoctorState();
  
}

class _DoctorState extends State<Doctor> {

  List<DoctorModel> doctorDetails = [];
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctorData();
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(
        itemCount: doctorDetails.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: doctorDetails[index]);
        },
      ),
    );
  }


  Future<List<DoctorModel>> getDoctorData () async {
    final response = await http.get(Uri.parse("http://192.168.1.130:3000/doctordatafetch"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        doctorDetails.add(DoctorModel.fromJson(index));

      }
      print(doctorDetails);
      return doctorDetails;
    }
    else{
      print("Doctor data cannot be fetched");
      return doctorDetails;
    }
  }
}


class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  DoctorCard({required this.doctor});

  @override
final String baseUrl = 'http://192.168.1.130:3000/';


  Widget build(BuildContext context) {

    String? replaceSlash = doctor.image.replaceAll(r'\', '/');
    String? imagePath = "$baseUrl$replaceSlash";

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imagePath), // Assuming image is a URL
            ),
            title: Text('${doctor.firstName} ${doctor.lastName}'),
            subtitle: Text(doctor.designation),
            onTap: () {
              // Handle doctor item tap
            },
          ),
        ],
      ),
    );
  }
}
