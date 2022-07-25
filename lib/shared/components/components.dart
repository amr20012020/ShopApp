import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constance.dart';


void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));


// ده ميثود بتخليني اتنقل للصفحه التانيه
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);


// ده لو عايز اظهر رساله سريعه
void showToast({
  required String? msg,
 // required ToastState state,
  message,
}) {
  Fluttertoast.showToast(
      msg: msg!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 14.0);
}

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.greenAccent;
      break;

    case ToastState.ERROR:
      color = Colors.redAccent;
      break;

    case ToastState.WARNING:
      color = Colors.orangeAccent;
      break;
  }
  return color;
}

enum ToastState {
  SUCCESS,
  ERROR,
  WARNING,
}

