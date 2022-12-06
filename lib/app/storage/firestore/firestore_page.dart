import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*
 * Page to test interaction with firestore.
 */
class FirestorePage extends StatefulWidget {
  const FirestorePage({super.key});

  @override
  FirestoreState createState() => FirestoreState();
}

class FirestoreState extends State<FirestorePage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> users =
        FirebaseFirestore.instance.collection('users').snapshots();

    CollectionReference userReference =
        FirebaseFirestore.instance.collection('users');

    String id = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore"),
      ),
      body: Column(
        children: [
          const Text("Read from firestore"),
          Container(
            height: 250,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: users,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      return Text(
                          "My name is ${snapshot.data!.docs[index]['id']}");
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          const SizedBox(height: 100),
          const Text("Write to firestore"),
          Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  id = value;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  userReference.add({'id': id}).then((value) {
                    if (kDebugMode) {
                      print('User added');
                    }
                  }).catchError((error) {
                    if (kDebugMode) {
                      print("$error");
                    }
                  });
                },
                child: const Text("Submit"),
              )
            ],
          )
        ],
      ),
    );
  }
}
