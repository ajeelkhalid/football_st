import 'package:flutter/material.dart';
import '../channe_screen.dart';
import './colors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import './getTeamName.dart';
import './getIcon.dart';
import '../all_matches.dart';

class MyMatches extends StatefulWidget {
  final String id;
  final String name;
  final String icon;
  const MyMatches(
      {required this.id, required this.name, required this.icon, Key? key})
      : super(key: key);

  @override
  State<MyMatches> createState() => MyMatchesState();
}

class MyMatchesState extends State<MyMatches> {
  String? id;
  var fireStore;

  // Add a refreshData() method to fetch updated data
  void refreshData(String id) {
    setState(() {
      this.id = id;
      fireStore = FirebaseFirestore.instance
          .collection('schedule')
          .where('leagueId', isEqualTo: id)
          .where('isLive', isEqualTo: true)
          .snapshots();
    });
  }

  @override
  void initState() {
    super.initState();
    id = widget.id;

    fireStore = FirebaseFirestore.instance
        .collection('schedule')
        .where('leagueId', isEqualTo: id)
        .where('isLive', isEqualTo: true)
        .snapshots();
  }

  var active = 0;

  void checkActive(index) {
    setState(() {
      active = index;
    });
  }

  final List categories = [
    'Premier League ajeel khalid',
    'La Liga',
    'World Cup',
    'Cricket'
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffFF2882),
                    ),
                  );
                }
                if (snapshot.data!.docs.length < 1) {
                  return Center(
                    child: Text("No Matche On That Time"),
                  );
                }
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            checkActive(index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChannelList(
                                          id: snapshot.data!.docs[index].id,
                                          teamOne: snapshot.data!.docs[index]
                                              ['teamOne'],
                                          teamTwo: snapshot.data!.docs[index]
                                              ['teamTwo'],
                                        )));
                            print(snapshot.data!.docs[index].id);
                          },
                          child: Container(
                            width: 320,
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color:
                                  index == active ? Colors.white : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.name,
                                    style: innerText,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Week 10',
                                    style: TextStyle(color: menuColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          GetIcon(
                                            snapshot.data!.docs[index]
                                                ["teamOne"],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          GetTeamName(snapshot.data!.docs[index]
                                              ["teamOne"]),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15, left: 15),
                                        child: Row(
                                          children: [
                                            Text(
                                              '  VS  ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff575757)),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          GetIcon(snapshot.data!.docs[index]
                                              ["teamTwo"]),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          GetTeamName(snapshot.data!.docs[index]
                                              ["teamTwo"]),
                                        ],
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                        );
                      })),
                );
              }),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Matches",
                  style: appText,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllMatches(
                                mid: widget.id,
                                name: widget.name,
                                icon: widget.icon)));
                  },
                  child: Text(
                    "See all",
                    style: seeAllText,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
