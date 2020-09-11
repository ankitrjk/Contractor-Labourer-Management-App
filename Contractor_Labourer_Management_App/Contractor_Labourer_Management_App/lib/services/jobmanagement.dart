import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire/services/authentication.dart';

final Auth auth = new Auth();
final databaseReference = Firestore.instance;

class JobManagement {
  Future createJob(jobdict) async {
    // await databaseReference.collection("jobs").document("1").setData({
    //   'title': 'Mastering Flutter',
    //   'description': 'Programming Guide for Dart'
    // });

    DocumentReference ref =
        await databaseReference.collection("jobs").add(jobdict);
    return ref.documentID;
  }

  Future getData() async {
    var res = new List();
    databaseReference
        .collection("jobs")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => res.add(f.data));
    });
    return res;
  }
}
