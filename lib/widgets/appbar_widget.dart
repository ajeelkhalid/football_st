import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar myAppBar() => AppBar(
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color(0xffF7F7F7),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: Color(0xffF7F7F7),
      elevation: 0,
      title: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "LI",
                style: TextStyle(
                    color: Color(0xff575757),
                    fontSize: 40,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "VER",
                style: TextStyle(
                    color: Color(0xff575757),
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
