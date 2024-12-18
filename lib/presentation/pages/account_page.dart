import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
@RoutePage()

// ignore: use_key_in_widget_constructors
class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account")),
      body: const Center(
        child: Text(
          "Account Information",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
