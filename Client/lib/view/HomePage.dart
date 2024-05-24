import 'package:ecardio/Providers/AuthProvider.dart';
import 'package:ecardio/Providers/ProvidePatientInfo.dart';
import 'package:ecardio/model/PatientDetails.dart';
import 'package:ecardio/services/fetchPatientDetails.dart';
import 'package:ecardio/services/ip_address.dart';
import 'package:ecardio/view/AppointmentPage.dart';
import 'package:ecardio/view/BookAppointmentPage.dart';
import 'package:ecardio/view/DailyRecommendation.dart';
import 'package:ecardio/view/Edges/CurvedEdges.dart';
import 'package:ecardio/view/Notification.dart';
import 'package:ecardio/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String> workoutMap = {
    'Skipping': 'assets/images/skipping.png',
    'Jumping Jack': 'assets/images/jumpingjack.png',
    'Mountain Climber': 'assets/images/mountainclimbers.png',
    'Jogging': 'assets/images/jogging.png',
    'Situps': 'assets/images/situps.png'
  };

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    PatientDetails? patientDetails = patientProvider.patientDetails;

    final String baseUrl = 'http://${newIP()}:3000/';

    Future<void> fetchPatient() async {
      if (authProvider.isLoggedIn && authProvider.userEmail != null) {
        patientProvider.fetchPatientDetails(authProvider.userEmail!);
      }
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await fetchPatient();
    });
    String? replaceSlash = patientDetails?.imagepath?.replaceAll(r'\', '/');
    String? imagePath = "$baseUrl$replaceSlash";
    String fullName =
        " ${patientDetails?.firstName} ${patientDetails?.lastName}";

    Widget buildWorkoutCard(String workoutName, String imagePath) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DailyRecommendationPage(id: '123456',)),
          );
        },
        child: Container(
          width: 120,
          height: 130,
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                   {}
                                  },
                                  child: CircleAvatar(
                                    radius: 32,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(imagePath ?? ''),
                                      radius: 29,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              fullName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
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
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Your Appointment',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentPage()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    surfaceTintColor: Colors.white,
                    elevation: 4,
                    child: SizedBox(
                      width: 370,
                      height: 90,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: AppColors.primaryColor,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/doc.png'),
                                    radius: 26,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. Muna Sherpa',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Follow-up consultation',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'MON 2023-10-9',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '12:00 PM',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Recommended Diet"),
                    ),
                  ],
                ),
                Container(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: buildWorkoutCard(
                            index == 0 ? 'Breakfast' : index == 1 ? 'Lunch' : 'Dinner',
                            index == 0 ? 'assets/images/Breakfast.png' : index == 1 ? 'assets/images/Lunch.png' : 'assets/images/Dinner.png'),
                      );
                    }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Recommended Workout Plans"),
                    ),
                  ],
                ),
                Container(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(workoutMap.length, (index) {
                      String workoutName = workoutMap.keys.elementAt(index);
                      String imagePath = workoutMap.values.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: buildWorkoutCard(workoutName, imagePath),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
