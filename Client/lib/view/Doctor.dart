import 'dart:convert';
import 'package:ecardio/model/doctor_model.dart';
import 'package:ecardio/services/ip_address.dart';
import 'package:ecardio/view/BookAppointmentPage.dart';
import 'package:ecardio/view/Edges/CurvedEdges.dart';
import 'package:ecardio/view/Notification.dart';
import 'package:ecardio/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class Doctor extends StatefulWidget {
  const Doctor({Key? key}) : super(key: key);

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  late Future<List<DoctorModel>> doctorData;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    doctorData = getDoctorData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CustomCurvedEdges(),
            child: Container(
              height: 150,
              color: AppColors.primaryColor,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 20, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 20.0),
                              child: TextFormField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Find your Doctor',
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  prefixIcon: Container(
                                    // color: Colors.black,
                                    width: 10,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.search,
                                          color: Color(0xFF34A77F),
                                        ),
                                      ],
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF34A77F),
                                        width: 1,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF34A77F),
                                        width: 1,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationPage(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.notifications_active_sharp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<DoctorModel>>(
              future: doctorData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: DoctorShimmer(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<DoctorModel> doctorDetails = snapshot.data!;
                  return ListView.builder(
                    itemCount: doctorDetails.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(doctor: doctorDetails[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<DoctorModel>> getDoctorData() async {
    final response =
        await http.get(Uri.parse("http://${newIP()}:3000/doctordatafetch"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      List<DoctorModel> doctorDetails =
          data.map((e) => DoctorModel.fromJson(e)).toList();
      return doctorDetails;
    } else {
      print("Doctor data cannot be fetched");
      throw Exception("Failed to fetch doctor data");
    }
  }
}

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final String baseUrl = 'http://${newIP()}:3000/';

  DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    String replaceSlash = doctor.image.replaceAll(r'\', '/');
    String imagePath = "$baseUrl$replaceSlash";

    return InkWell(
      onTap: () {
        // Navigate to the next page and pass the doctor ID
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookAppointment(docID: doctor.doctorId)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${doctor.firstName} ${doctor.lastName}',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        doctor.designation,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Iconsax.star5,
                              size: 18,
                              color: AppColors.primaryColor,
                              fill: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 2, 0, 0),
                            child: Text(
                              "${doctor.rating}/5",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DoctorShimmer extends StatelessWidget {
  const DoctorShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Specify the number of shimmer blocks you want to display
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 18.0,
                                height: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 40.0,
                                height: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
