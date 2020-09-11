//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fire/pages/dashboard.dart';
import 'package:flutter_fire/services/authentication.dart';

import 'profilepage.dart';
import 'upload_post.dart';
import 'myjob.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

// class _HomePageState extends State<HomePage> {
//   signOut() async {
//     try {
//       await widget.auth.signOut();
//       widget.logoutCallback();
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//           title: new Text('Flutter_fire (HomePage)'),
//           actions: <Widget>[
//             new FlatButton(
//                 child: new Text('Logout',
//                     style: new TextStyle(fontSize: 17.0, color: Colors.white)),
//                 onPressed: signOut)
//           ],
//         ),
//         body: Center(child: Text(
//           'Welcome To Homepage.!, \n${widget.userId}',
//             style: TextStyle(color: Colors.red,
//             fontSize: 20.0, fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: Colors.teal,
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(icon: Icon(Icons.home)),
            new Tab(icon: Icon(Icons.chat)),
            new Tab(icon: Icon(Icons.group)),
            new Tab(icon: Icon(Icons.person)),
          ],
        ),
      ),
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[
          DashboardPage(
            userId: widget.userId,
            auth: widget.auth,
            logoutCallback: widget.logoutCallback,
          ),
          // Posts(),
          MyJob(),
          UploadPost(),
          ProfilePage()
        ],
      ),
    );
  }
}
