import 'package:ecardio/Routes.dart';
import 'package:ecardio/view/Doctor.dart';
import 'package:ecardio/view/Toasts/Toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:http/http.dart' as http;


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Text Controllers

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool hide = true;

  File? selectedImage;

  final _formKey = GlobalKey<FormState>();

   registerSucessMethod() async {
    Toast.registerSuccessToast(context);
    await Future.delayed(const Duration(seconds: 4));

    Navigator.pushNamed(context, Routes.bottomNavbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Padding(
        //           padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        //           child: Image.asset('assets/images/logo.png', scale: 4.5,),
        //         ),
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        //   elevation: 1,
        // ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    // Image.asset(
                    //   'assets/images/logo.png',
                    //   scale: 4.5,
                    // ),

                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   child: selectedImage != null
                    //       ? Image.file(selectedImage!)
                    //       : const Text('Please Select Image from your Gallery'),
                    // ),

                    // Image.file(selectedImage!)
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade200,
                          child: selectedImage != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(selectedImage!),
                                  radius: 60,
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.png'),
                                  radius: 60,
                                ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(2, 4),
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 3,
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: InkWell(
                                  onTap: () => pickImageGallery(),
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: Color(0xFF34A77F),
                                    size: 15,
                                  )),
                              // child: Icon(Icons.add_a_photo, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //First name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: _firstName,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your First Name',
                          prefixIcon: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  // FontAwesomeIcons.user,
                                  Icons.person,
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

                    //Last Name

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: _lastName,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your Last Name',
                          prefixIcon: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  // FontAwesomeIcons.user,
                                  Icons.person,

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

                    //phone number

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: _phoneNumber,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your Phone Number',
                          prefixIcon: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  // FontAwesomeIcons.phone,
                                  Icons.phone,
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

                    //Email address
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your Email Address',
                          prefixIcon: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                // Icon(Icons.email),
                                const Icon(
                                  Icons.email,
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
                          prefixIcon: SizedBox(
                            // color: Colors.black,
                            width: 70,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  Icons.password,

                                  // FontAwesomeIcons.fingerprint,
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
                      height: 10,
                    ),

                    const SizedBox(
                      height: 10,
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
                        // Create a FormData object to include both form fields and the file
                        var formData = http.MultipartRequest('POST',
                            Uri.parse('http://192.168.1.80:3000/signup'));

                        // Add form fields
                        formData.fields.addAll({
                          'first_name': _firstName.text,
                          'last_name': _lastName.text,
                          'phone_number': _phoneNumber.text,
                          'email': _emailController.text,
                          'password': _passwordController.text,
                        });

                        // Add file
                        if (selectedImage != null) {
                          formData.files.add(
                            await http.MultipartFile.fromPath(
                                'image', selectedImage!.path),
                          );
                        }

                        // Send the request
                        var response = await formData.send();

                        

                        // Get the response as a string
                        var responseString =
                            await response.stream.bytesToString();

                        // Print the response for debugging
                        // print('Response: $responseString');

                        print(response.statusCode);

                        if (responseString == "User Registration Successfully" ) {
                          registerSucessMethod();
                        }
                        else{
                          Toast.registerFailToast(context);
                        }

                        print(_firstName.text);
                        print(_lastName.text);
                        print(_phoneNumber.text);

                        print(_emailController.text);
                        print(_passwordController.text);
                        print(selectedImage.toString());
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Doctor()));

                            // Navigator.pushNamed(context, Routes.signUpScreen);
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         child: const SignupScreen(),
                            //         type: PageTransitionType.fade));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Color(0xFF34A77F)),
                          )),
                    ])
                  ],
                ),
              )),
        ));
  }

  //Image Pick from Gallery
  Future pickImageGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }

  Future pickImageCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }
}
