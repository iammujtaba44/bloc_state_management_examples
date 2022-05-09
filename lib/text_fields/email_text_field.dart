import 'package:bloc_tutorial/strings.dart' show enterYourEmail;
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController? emailController;

  const EmailTextField({Key? key, required this.emailController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(hintText: enterYourEmail),
    );
  }
}
