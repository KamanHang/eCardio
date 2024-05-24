import 'package:ecardio/Providers/ProvideDocDetail.dart';
import 'package:ecardio/model/DocDetails.dart';
import 'package:ecardio/services/ip_address.dart';
import 'package:ecardio/view/CheckOutPage.dart';
import 'package:ecardio/view/Edges/CurvedEdges.dart';
import 'package:ecardio/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class BookAppointment extends StatefulWidget {
  final int docID;

  const BookAppointment({Key? key, required this.docID, int? patientID}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  late int doctorID;

  @override
  void initState() {
    super.initState();
    doctorID = widget.docID;
    fetchDoctor();
  }

  Future<void> fetchDoctor() async {
    final docProvider = Provider.of<DocProvider>(context, listen: false);
    await docProvider.fetchDoctorDetails(doctorID);
  }

  @override
  Widget build(BuildContext context) {
    final docProvider = Provider.of<DocProvider>(context);
    DocModel? doctorDetail = docProvider.docDetails;

    final String baseUrl = 'http://${newIP()}:3000/';

    String? replaceSlash = doctorDetail?.image?.replaceAll(r'\', '/');
    String? imagePath = replaceSlash != null ? "$baseUrl$replaceSlash" : null;
    String fullName =
        "${doctorDetail?.firstName ?? ''} ${doctorDetail?.lastName ?? ''}";

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: Container(
                height: 30,
                color: AppColors.primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: imagePath != null
                          ? Image.network(imagePath)
                          : Placeholder(), // Placeholder if image path is null
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. ${fullName}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        doctorDetail?.designation ?? '',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Madan Hospital, Kathmandu',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Iconsax.star5,
                            size: 15,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 5),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                            child: Text(
                              '${doctorDetail?.rating ?? 0}/5 (3200 reviews)',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 50),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                surfaceTintColor: Colors.white,
                child: Container(
                  constraints: BoxConstraints(minWidth: 400, maxWidth: 400),
                  // Set constraints for the card width
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                      SizedBox(height: 5),
                      Text(
                        doctorDetail?.description ?? '',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                surfaceTintColor: Colors.white,
                child: SizedBox(
                  width: 370,
                  height: 80,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Availability',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              doctorDetail?.workingTime ?? '',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                surfaceTintColor: Colors.white,
                child: const SizedBox(
                  width: 370,
                  height: 70,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Appointment Fee',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Rs. 700 only',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Color(0XFF34A77F)),
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CheckOutPage()));
                    },
                    child: const Text(
                      'Book Appointment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
