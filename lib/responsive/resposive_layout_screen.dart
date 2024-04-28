import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelbuddy/providers/user_provider.dart';
import 'package:travelbuddy/utils/global_variables.dart';

class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayoutScreen({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  });

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {
  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);

    await userProvider.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.webScreenLayout;
      } else {
        return widget.mobileScreenLayout;
      }
    });
  }
}
