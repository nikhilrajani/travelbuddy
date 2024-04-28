import 'package:flutter/material.dart';
import 'package:travelbuddy/resources/auth_methods.dart';
import 'package:travelbuddy/responsive/mobile_screen_layout.dart';
import 'package:travelbuddy/responsive/resposive_layout_screen.dart';
import 'package:travelbuddy/responsive/web_screen_layout.dart';
import 'package:travelbuddy/screens/signup_screen.dart';
import 'package:travelbuddy/utils/colors.dart';
import 'package:travelbuddy/utils/utils.dart';
import 'package:travelbuddy/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final currentContext = context;
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (currentContext.mounted) {
      if (res == "success") {
        Navigator.of(currentContext).pushReplacement(
          MaterialPageRoute(
            builder: (currentContext) => const ResponsiveLayoutScreen(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      } else {
        showSnackBar(res, currentContext);
      }
    }
  }

  void navigateToSignUp() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //logo
              Flexible(flex: 2, child: Container()),
              Image.asset(
                'assets/logo-white.png',
                height: 200,
              ),

              // const SizedBox(height: 10),

              //text field input for email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              //text field input for password
              TextFieldInput(
                textEditingController: _passwordController,
                isPass: true,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
              ),

              const SizedBox(height: 24),

              //login button
              InkWell(
                onTap: () {
                  loginUser(context);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Login'),
                ),
              ),

              const SizedBox(height: 12),

              Flexible(flex: 2, child: Container()),
              //transition to signup/forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text("Don't have an account? "),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Sign Up!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
