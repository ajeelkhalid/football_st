// ignore: file_names
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import './getTeamName.dart';
import './getIconCard.dart';

class GetAll extends StatefulWidget {
  final String id;
  const GetAll({required this.id});

  @override
  State<GetAll> createState() => GetAllState();
}

class GetAllState extends State<GetAll> {
  String? id;
  var fireStore;

  // Add a refreshData() method to fetch updated data
  void refreshData(String id) {
    setState(() {
      this.id = id;
      fireStore = FirebaseFirestore.instance
          .collection('schedule')
          .where('leagueId', isEqualTo: id)
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
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStore,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            height:
                snapshot.data!.docs.length * 70, // Adjust the height as needed
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                    right: 7,
                    left: 7,
                    bottom: 15,
                  ),
                  width: double.infinity,
                  height: 75,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    shadowColor: Colors.white70,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              GetTeamName(
                                  snapshot.data!.docs[index]["teamOne"]),
                              const SizedBox(width: 7),
                              GetIconCard(
                                  snapshot.data!.docs[index]["teamOne"]),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("06:30 am"),
                            SizedBox(height: 5),
                            Text(
                              "30 Oct",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xfff02D79),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              GetIconCard(
                                  snapshot.data!.docs[index]["teamTwo"]),
                              const SizedBox(width: 11),
                              GetTeamName(
                                  snapshot.data!.docs[index]["teamTwo"]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
