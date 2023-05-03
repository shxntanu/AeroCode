import 'package:flutter/material.dart';
import 'colors.dart';

void showSnackbar(BuildContext context, String data,
    {Duration? kDuration, Color? bgColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      data, 
      style: const TextStyle(
        color: darkPurple,
        ),
    ),
    backgroundColor: bgColor ?? Colors.white,
    duration: kDuration ?? const Duration(seconds: 3),
  ));
}