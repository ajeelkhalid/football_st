import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class GetTeamName extends StatelessWidget {
  final String documentId;

  GetTeamName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('teams');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Wrong",
            style: innerText,
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text(
            "No Match",
            style: innerText,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            data['name'],
            style: innerText,
          );
        }

        return Text(
          "loading",
          style: innerText,
        );
      },
    );
  }
}
