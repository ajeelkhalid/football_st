import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liver/widgets/getIconCard.dart';
import 'package:liver/widgets/getTeamName.dart';

class ChannelList extends StatefulWidget {
  final String id;
  final String teamOne;
  final String teamTwo;
  const ChannelList(
      {super.key,
      required this.id,
      required this.teamOne,
      required this.teamTwo});

  @override
  State<ChannelList> createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  String? id;
  var fireStore;

  @override
  void initState() {
    super.initState();
    id = widget.id;

    fireStore = FirebaseFirestore.instance
        .collection('schedule')
        .where('teamOne', isEqualTo: widget.teamOne)
        .where('teamTwo', isEqualTo: widget.teamTwo)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 32,
          weight: 24,
        ),
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
      ),
      backgroundColor: const Color(0xffF7F7F7),
      body: StreamBuilder<QuerySnapshot>(
          stream: fireStore,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xffFF2882),
                ),
              );
            }
            if (snapshot.data!.docs.length <= 0) {
              return Center(
                child: Text("No Matche On That Time"),
              );
            }
            return SizedBox(
              // Adjust the height as needed
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var teamData =
                      snapshot.data!.docs.first.data() as Map<String, dynamic>;

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
                                Text(snapshot
                                    .data!.docs[index]["channel"].length
                                    .toString()),
                                const SizedBox(width: 7),
                                Text(snapshot.data!.docs[index]["channel"][0]),
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
          }),
    );
  }
}
