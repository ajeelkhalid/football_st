import 'package:flutter/material.dart';
import './widgets/colors.dart';
import './widgets/menu_widget.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  void parentMethod() {
    print("Parent method called");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: backColor,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0),
              child: Column(
                children: [MyMenu()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
