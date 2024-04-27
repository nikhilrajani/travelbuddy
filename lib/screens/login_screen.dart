import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbuddy/widgets/logo_display.dart';
// import 'package:travelbuddy/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //svg image
              LogoDisplay(),
              SizedBox(height: 64),
              Text('Hello from login screen')
              //text field input for email
              //text field input for password
              //login button
              //transition to signup/forgot password
            ],
          ),
        ),
      ),
    );
  }
}
