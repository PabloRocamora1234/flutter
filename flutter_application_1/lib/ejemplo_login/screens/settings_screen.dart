import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  static const String routerName = "Settings";

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("SETTING"),
      ),
    );
  }
}