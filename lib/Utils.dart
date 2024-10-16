import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
class Utils{
  // next field focused in textField
  static fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus,){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static flushBarSuccessMessage(String message , BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        positionOffset: 20,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(20),
        icon: const Icon(Icons.verified ,size: 28,color: Colors.white,),
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.lightGreen,
        messageColor: Colors.white,
        duration: const Duration(seconds: 3),
      )..show(context),
    );}

  static flushBarErrorMessage(String message , BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        positionOffset: 20,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(20),
        icon: const Icon(Icons.error ,size: 28,color: Colors.white,),
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.red,
        messageColor: Colors.white,
        duration: const Duration(seconds: 3),
      )..show(context),
    );}
}