import 'package:bloc_tutorial/strings.dart' show enterYourPassword;
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController? controller;

  const PasswordTextField({Key? key, required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(hintText: enterYourPassword),
    );
  }
}
