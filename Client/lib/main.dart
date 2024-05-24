import 'package:ecardio/Providers/ProvideDocDetail.dart';
import 'package:ecardio/Providers/ProvidePatientInfo.dart';
import 'package:ecardio/Routes.dart';
import 'package:ecardio/SplashScreen.dart';
import 'package:ecardio/view/AppointmentPage.dart';
import 'package:ecardio/view/BottomNavigationBar.dart';
import 'package:ecardio/view/HomePage.dart';
import 'package:ecardio/view/RegisterPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';
import './view/LoginPage.dart';
import 'package:ecardio/Providers/AuthProvider.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => PatientProvider()),
      ChangeNotifierProvider(create: (_) => DocProvider()),
    ],
    child: MyApp(),
  ));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      builder: (context, navKey) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          routes: {
            Routes.loginScreen: ((context) => LoginPage()),
            Routes.signUpScreen: ((context) => Register()),
            Routes.homePage: ((context) => HomePage()),
            Routes.appointment: (context) => AppointmentPage(),
            Routes.bottomNavbar: (context) => BottomNavBar(),
          },
          navigatorKey: navKey,
          localizationsDelegates: const [KhaltiLocalizations.delegate],
        );
      },
      publicKey: 'test_public_key_dc006e10a4204acd8cad6e95f1f26edf',
    );
  }
}
