import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoDisplay extends StatelessWidget {
  const LogoDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/logo-white.svg');
  }
}
