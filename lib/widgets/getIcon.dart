import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetIcon extends StatelessWidget {
  final String documentId;

  GetIcon(this.documentId);

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
            height: 80,
            width: 80,
          );
        }

        return Text("Loading");
      },
    );
  }
}
