import 'package:flutter/material.dart';
import 'package:ecardio/model/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(doctor.image ?? ''), // Assuming image is a URL
        ),
        title: Text('${doctor.firstName ?? ''} ${doctor.lastName ?? ''}'),
        subtitle: Text(doctor.designation ?? ''),
        onTap: () {
          // Handle doctor item tap
        },
      ),
    );
  }
}
