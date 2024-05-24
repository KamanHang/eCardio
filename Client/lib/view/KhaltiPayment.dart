import 'package:ecardio/view/CheckOutPage.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PaymentKhalti extends StatefulWidget {
  const PaymentKhalti({super.key});

  @override
  State<PaymentKhalti> createState() => _PaymentKhaltiState();
}

class _PaymentKhaltiState extends State<PaymentKhalti> {
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: 'test_public_key_dc006e10a4204acd8cad6e95f1f26edf',
        enabledDebugging: true,
        builder: (context, navKey) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: CheckOutPage(),
            navigatorKey: navKey,
            localizationsDelegates: const [KhaltiLocalizations.delegate],
          );
        });
  }

  
}
 
 