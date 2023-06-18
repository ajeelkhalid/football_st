import 'package:flutter/material.dart';
import './widgets/getAllMatch.dart';

class AllMatches extends StatelessWidget {
  final String mid;
  final String name;
  final String icon;

  AllMatches(
      {required this.mid, required this.name, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 32,
          weight: 24,
        ),
        backgroundColor: const Color(0xFFF6F7F9),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          left: 5,
          right: 5,
          bottom: 5,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: size.height * 0.32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF6F7F9),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(66),
                        bottomLeft: Radius.circular(66),
                      ),
                    ),
                    child: Column(
                      children: [
                        Hero(
                          tag: 1,
                          child: Center(
                            child: Image.network(
                              this.icon,
                              height: 180,
                              width: 180,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                            bottom: 15,
                          ),
                          child: Text(
                            this.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )),
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        GetAll(
                          id: this.mid,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
