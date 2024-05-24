import 'package:ecardio/view/DailyRecommendation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    // Mock notification data for demonstration
    DateTime notificationDateTime = DateTime.now();
    String formattedDateTime =
        DateFormat('EEE, MMM d, y h:mm a').format(notificationDateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notification"),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: 100.0, // Set the desired height here
          child: InkWell(
            onTap: () {
              // Navigate to the DailyRecommendationPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DailyRecommendationPage(id: 'Notification'),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Row(
                      children: [
                        Image.asset(
                      'assets/images/mountainclimbers.png', fit: BoxFit.cover,
                      height: 50.0, // Adjust height as needed
                      width: 50.0,
                    ),
                    SizedBox(width: 20,),
                   Column(
                    children: [
                       Text(
                      'Daily Dose of Exercise',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      formattedDateTime,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    ],
                   )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
