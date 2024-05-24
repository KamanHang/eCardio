import 'package:ecardio/services/notification_services.dart';
import 'package:ecardio/view/DataVisualization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecardio/view/MedicalReport.dart';
import 'package:ecardio/view/Analyze.dart';
import 'package:ecardio/view/Doctor.dart';
import 'package:ecardio/view/HealthBlogs.dart';
import 'package:ecardio/view/HomePage.dart';
import 'package:ecardio/view/ShopPage.dart';
import 'package:ecardio/view/UserProfile.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.getDeviceToken().then((value){
        print('Device Token');
        print('Token: '+ value);

    });    
  }
  int currentIndex = 0;

  void goToPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<dynamic> _pages = [
    HomePage(),
    AnalyzeData(),
    MedicalReportPage(),
    DataVisualization(),
    Doctor(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: SizedBox( // Wrap ListView.builder with SizedBox
          height: size.width * .155, // Set a fixed height
          child: ListView.builder(
            itemCount: _pages.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: size.width * .024),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    margin: EdgeInsets.only(
                      bottom: index == currentIndex ? 0 : size.width * .029,
                      right: size.width * .0422,
                      left: size.width * .0422,
                    ),
                    width: size.width * .128,
                    height: index == currentIndex ? size.width * .014 : 0,
                    decoration: BoxDecoration(
                      color: Color(0xFF34A77F),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                  Icon(
                    listOfIcons[index],
                    size: size.width * .065,
                    color: index == currentIndex
                        ? Color(0xFF34A77F)
                        : Colors.black38,
                  ),
                  SizedBox(height: size.width * .03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.fileMedical,
    Iconsax.chart_1,
    FontAwesomeIcons.userDoctor,
    FontAwesomeIcons.idBadge,
  ];
}
