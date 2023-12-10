import 'dart:async';

import 'package:ecardio/Routes.dart';
import 'package:ecardio/services/loginAuth.dart';
import 'package:ecardio/view/RegisterPage.dart';
import 'package:ecardio/view/Toasts/Toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool hide = true;

  final _formKey = GlobalKey<FormState>();

  loginSucessMethod() async {
    Toast.loginSuccessToast(context);
    await Future.delayed(const Duration(seconds: 4));

    Navigator.pushNamed(context, Routes.bottomNavbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        scale: 2.5,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your Email Address',

                          // prefixIcon: Icon(
                          //   Icons.email,
                          //   color: Colors.blue,

                          // ),
                          prefixIcon: Container(
                            // color: Colors.black,
                            width: 70,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  FontAwesomeIcons.phone,
                                  color: Color(0xFF34A77F),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  height: 10,
                                  thickness: 2,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.grey.shade300),
                                ),
                              ],
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFF34A77F),
                                width: 2,
                              )),

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFF34A77F),
                                width: 2,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: hide ? true : false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your Password',
                          suffixIcon: InkWell(
                              onTap: () => setState(() {
                                    hide = !hide;
                                    // Icon(Icons.remove_red_eye, color: Colors.black);
                                  }),
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Colors.green.shade300,
                              )),

                          // prefixIcon: Icon(
                          //   Icons.email,
                          //   color: Colors.blue,

                          // ),
                          prefixIcon: Container(
                            // color: Colors.black,
                            width: 70,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  FontAwesomeIcons.fingerprint,
                                  color: Color(0xFF34A77F),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  height: 10,
                                  thickness: 2,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.grey.shade300),
                                ),
                              ],
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFF34A77F),
                                width: 2,
                              )),

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFF34A77F),
                                width: 2,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Color(0xFF34A77F)),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15)),
                          shape:
                              MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ))),
                      onPressed: () async {
                        String? response = await LoginStudent.login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        print('Response: $response');

                        if (response == "200") {
                          loginSucessMethod();
                        } else {
                          Toast.loginFailToast(context);
                        }

                        print(_emailController.text);
                        print(_passwordController.text);

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
                        // print(_emailController.text);
                        // print(_passwordController.text);
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));

                            // Navigator.pushNamed(context, Routes.signUpScreen);
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         child: const SignupScreen(),
                            //         type: PageTransitionType.fade));
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Color(0xFF34A77F)),
                          )),
                    ])
                  ],
                ),
              )),
        ));
  }
}
