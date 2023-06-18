import 'package:flutter/material.dart';
import './widgets/appbar_widget.dart';
import './widgets/bottom_navigation.dart';
import './home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: myAppBar(),
            backgroundColor: Color(0xffF7F7F7),
            body: MyHome(),
            bottomNavigationBar: BottomNavigation()));
  }
}
