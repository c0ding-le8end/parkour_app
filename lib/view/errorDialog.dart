import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context)
{
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    headerAnimationLoop: false,

    desc:
    'An Error Occurred! Please Try Again',
    btnOkOnPress: () {},
    btnOkIcon: Icons.cancel,
    btnOkColor: const Color(0xFF931800),
  ).show();
}

void showAlertDialog(BuildContext context)
{
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    desc: 'Please remove your vehicle from the parking slot before making a payment',
    buttonsTextStyle: const TextStyle(color: Colors.black),

    btnOkOnPress: () {},
  ).show();
}