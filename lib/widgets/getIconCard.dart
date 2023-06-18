import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetIconCard extends StatelessWidget {
  final String documentId;

  GetIconCard(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('teams');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Loading");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Image.network(
            data['icon'],
            height: 40,
            width: 40,
          );
        }

        return Text("Loading");
      },
    );
  }
}
