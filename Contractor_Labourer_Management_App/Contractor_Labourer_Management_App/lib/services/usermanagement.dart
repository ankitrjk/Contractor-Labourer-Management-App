import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fire/services/authentication.dart';

final Auth auth = new Auth();
final databaseReference = Firestore.instance;

class UserManagement {
  storeNewUser(user, context) {
    databaseReference.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl
    }).then((value) {
      //Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }

  Future updateProfilePic(picUrl) async {
    var userInfo = new UserUpdateInfo();
    userInfo.photoUrl = picUrl;

    FirebaseUser user = await auth.getCurrentUser();
    await user.updateProfile(userInfo);
    await user.reload();
    user = await auth.getCurrentUser().then((user) {
      databaseReference
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        Firestore.instance
            .document('/users/${docs.documents[0].documentID}')
            .updateData({'photoUrl': picUrl}).then((val) {
          print('Updated');
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future updateNickName(String newName) async {
    var userInfo = new UserUpdateInfo();
    userInfo.displayName = newName;

    FirebaseUser user = await auth.getCurrentUser();
    await user.updateProfile(userInfo);
    await user.reload();
    user = await auth.getCurrentUser().then((user) {
      databaseReference
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((doc) {
        Firestore.instance
            .document('/users/${doc.documents[0].documentID}')
            .updateData({'displayName': newName}).then((val) {
          print('updated');
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {});
    }).catchError((e) {});
  }
}
