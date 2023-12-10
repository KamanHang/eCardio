
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';


class Toast {
  static void loginSuccessToast(context) {
  toastification.show(
	  context: context,
	  type: ToastificationType.success,
	  style: ToastificationStyle.minimal,
	  title: 'Login Success',
	  description: 'Logging User! Please Wait...',
	  alignment: Alignment.topRight,
	  autoCloseDuration: const Duration(seconds: 4),
	);
  
  }


  static void loginFailToast(context) {
 toastification.show(
	  context: context,
	  type: ToastificationType.error,
	  style: ToastificationStyle.minimal,
	  title: 'Login Failed',
	  description: 'Please Check your credential',
	  alignment: Alignment.topRight,
	  autoCloseDuration: const Duration(seconds: 4),
	);


  }



   static void registerSuccessToast(context) {
  toastification.show(
	  context: context,
	  type: ToastificationType.success,
	  style: ToastificationStyle.minimal,
	  title: 'Register Success',
	  description: 'Logging User! Please Wait...',
	  alignment: Alignment.topRight,
	  autoCloseDuration: const Duration(seconds: 4),
	);
  
  }


  static void registerFailToast(context) {
 toastification.show(
	  context: context,
	  type: ToastificationType.error,
	  style: ToastificationStyle.minimal,
	  title: 'Register Failed',
	  description: 'Check your Credential',
	  alignment: Alignment.topRight,
	  autoCloseDuration: const Duration(seconds: 4),
	);


  }
}
