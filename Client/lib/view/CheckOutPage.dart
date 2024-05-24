import 'package:ecardio/Providers/ProvideDocDetail.dart';
import 'package:ecardio/Providers/ProvidePatientInfo.dart';
import 'package:ecardio/model/DocDetails.dart';
import 'package:ecardio/model/PatientDetails.dart';
import 'package:ecardio/services/BookAppointmentService.dart';
import 'package:ecardio/services/ip_address.dart';
import 'package:ecardio/view/Edges/CurvedEdges.dart';
import 'package:ecardio/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  String? selectedDropdownValue;

  String paymentStatus = "";

  String? patientName = "";
  String? patientEmail = "";
  String? doctorEmail = "";
  

  String referenceId = "";

  String? year = "";
  String? month = "";
  String? day = "";
  String? weekDay = "";
  String? selectedDate = "Select Date";
  String? selectedTime = "Select Time";

  PatientDetails? patientDetails;
  DocModel? doctorDetail;

  String fullName = "";

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((value) {
      if (value != null) {
        setState(() {
          year = value.year.toString();
          month = value.month.toString();
          day = value.day.toString();
          selectedDate = year! + "-" + month! + "-" + day!;

          weekDay = DateFormat('EEEE').format(value);
          print(weekDay); // This will print the weekday name
        });
      }
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedTime = value.format(context);
          print(selectedTime); // Format the selected time
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    patientDetails = patientProvider.patientDetails;
    final docProvider = Provider.of<DocProvider>(context);
    doctorDetail = docProvider.docDetails;
    final String baseUrl = 'http://${newIP()}:3000/';

    String? replaceSlash = doctorDetail?.image?.replaceAll(r'\', '/');
    String? imagePath = replaceSlash != null ? "$baseUrl$replaceSlash" : null;
    fullName =
        "${doctorDetail?.firstName ?? ''} ${doctorDetail?.lastName ?? ''}";

    patientName = "${patientDetails?.firstName} ${patientDetails?.lastName}";
    patientEmail = patientDetails?.email;
    doctorEmail = doctorDetail?.email;

    print(patientName);
    print(patientEmail);
    print(doctorEmail);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appointment Summary",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
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
                    width: 85,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: imagePath != null
                          ? Image.network(imagePath)
                          : Image.asset(
                              "assets/images/avatar.png"), // Placeholder if image path is null
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
                        'Madan Hospital, Itahari',
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
                              '${doctorDetail?.rating ?? 0}/5',
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
              // padding: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                surfaceTintColor: Colors.white,
                child: Container(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 350),
                  // Set constraints for the card width
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Doctor Availability',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    doctorDetail?.workingTime ?? '',
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.black),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,

                          //       children: [
                          //         Text(
                          //       'Current Date and Time',
                          //       style: TextStyle(
                          //           fontSize: 10,
                          //           fontWeight: FontWeight.bold,
                          //           color: AppColors.primaryColor),
                          //     ),
                          //     Text(
                          //       todayDate,
                          //       style: TextStyle(
                          //           fontSize: 10,
                          //           fontWeight: FontWeight.w200,
                          //           color: Colors.black),
                          //     ),
                          //       ],
                          //     )
                          //   ],
                          // ),
                        ],
                      )
                      // Text(
                      //   '',
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.bold,
                      //       color: AppColors.primaryColor),
                      // ),
                      // SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                surfaceTintColor: Colors.white,
                child: Container(
                  constraints: BoxConstraints(minWidth: 200, maxWidth: 350),
                  // Set constraints for the card width
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Reason of Appointment',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor),
                          ),
                          DropdownButton(
                            hint: Text(
                              "Follow-up",
                              style: TextStyle(fontSize: 12),
                            ),
                            items: dropdownItems,
                            value: selectedDropdownValue,
                            icon: Icon(Iconsax.arrow_down_14),
                            onChanged: (newValue) => {
                              setState(() {
                                selectedDropdownValue = newValue!;
                                print(selectedDropdownValue);
                                //     print(selectedDropdownValue);
                              })
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    surfaceTintColor: Colors.white,
                    child: Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
                      // Set constraints for the card width
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(selectedDate!),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton.icon(
                                    icon: const Icon(
                                      Iconsax.calendar,
                                      color: AppColors.secondaryColor,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          // If the button is pressed, return green, otherwise blue
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return Colors.green;
                                          }
                                          return AppColors.primaryColor;
                                        }),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ))),
                                    label: Text(
                                      "Date",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      _showDatePicker();
                                    },
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    surfaceTintColor: Colors.white,
                    child: Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
                      // Set constraints for the card width
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  Text(selectedTime!),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton.icon(
                                    icon: const Icon(
                                      Iconsax.clock,
                                      color: AppColors.secondaryColor,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          // If the button is pressed, return green, otherwise blue
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return Colors.green;
                                          }
                                          return AppColors.primaryColor;
                                        }),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ))),
                                    label: Text(
                                      "Time",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      _showTimePicker();
                                    },
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14,),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll(Color(0XFF34A77F)),
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ))),
              onPressed: () async {
                payWithKhalti();
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void bookAppointment() async {
    if (paymentStatus == "Payment Success") {
      String? response = await BookService.book(
        appointment_type: selectedDropdownValue!,
        appointment_date: selectedDate!,
        appointment_time: selectedTime!,
        patient_id: patientDetails!.patientId,
        doctor_id: doctorDetail!.doctorId,
        week_day: weekDay!,
        patient_name: patientName!,
        doctor_name: fullName,
        patientEmail: patientEmail!,
      );
      debugPrint(response.toString());
    }
  }

  void payWithKhalti() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 20000,
        productIdentity: "Appointment",
        productName: doctorEmail!,
      ),
      preferences: [PaymentPreference.khalti],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    debugPrint(success.toString());

    print(success);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Payment Successful"),
          actions: [
            SimpleDialogOption(
              child: const Text("Ok"),
              onPressed: () {
                setState(() {
                  paymentStatus = "Payment Success";
                });
                bookAppointment();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Payment Failed"),
          actions: [
            SimpleDialogOption(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void onCancel() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Payment Cancelled"),
          actions: [
            SimpleDialogOption(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Follow-Up", style: TextStyle(fontSize: 12)),
          value: "Follow-Up"),
      DropdownMenuItem(
          child: Text("Diagnostic-Testing", style: TextStyle(fontSize: 12)),
          value: "Diagnostic-Testing"),
      DropdownMenuItem(
          child: Text("Medication-Check", style: TextStyle(fontSize: 12)),
          value: "Medication-Check"),
      DropdownMenuItem(
          child: Text("Exercise-&-Education", style: TextStyle(fontSize: 12)),
          value: "Exercise-&-Education"),
    ];
    return menuItems;
  }
}
