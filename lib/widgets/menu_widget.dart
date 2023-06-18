import 'package:flutter/material.dart';
import './colors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import './card_widget.dart';
import 'matches_widget.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({Key? key}) : super(key: key);

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  var active = 4;
  var idLeague = "ie4oNclaswtZcrVjChw6";
  var nameLeague = "Premier League";
  var iconLeague =
      "https://cdn.discordapp.com/attachments/1107878800831819828/1114892519382196264/32207-5-premier-league-file.png";
  final fireStore = FirebaseFirestore.instance.collection('league').snapshots();

  // Create a GlobalKey for MyMatches and MyCard widgets
  final GlobalKey<MyMatchesState> matchesKey = GlobalKey<MyMatchesState>();
  final GlobalKey<MyCardState> cardKey = GlobalKey<MyCardState>();

  void checkActive(index, id, name, icon) {
    setState(() {
      active = index;
      idLeague = id;
      nameLeague = name;
      iconLeague = icon;

      // Call refreshData() on MyMatches and MyCard widgets' states
      matchesKey.currentState?.refreshData(id);
      cardKey.currentState?.refreshData(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
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
                  return SizedBox(
                    height: 55,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            checkActive(
                                index,
                                snapshot.data!.docs[index].id,
                                snapshot.data!.docs[index]["name"],
                                snapshot.data!.docs[index]["icon"]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color:
                                  index == active ? themeColor : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  checkActive(
                                      index,
                                      snapshot.data!.docs[index].id,
                                      snapshot.data!.docs[index]["name"],
                                      snapshot.data!.docs[index]["icon"]);
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Image.network(
                                        snapshot.data!.docs[index]["icon"],
                                        height: 35,
                                        width: 35,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]["name"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: index == active
                                            ? Colors.white
                                            : menuColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("", style: seeAllText),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Live Match",
                      style: appText,
                    ),
                  ),
                ],
              ),
              // Use GlobalKey to access the state of MyMatches widget
              MyMatches(
                key: matchesKey,
                id: idLeague,
                name: nameLeague,
                icon: iconLeague,
              ),
              MyCard(
                key: cardKey,
                id: idLeague,
              )
            ],
          ),
        ),
      ),
    );
  }
}
