import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  const Login({Key? key,required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

    );
  }
}
