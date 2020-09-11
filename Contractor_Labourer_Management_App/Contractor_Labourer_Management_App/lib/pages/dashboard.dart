import 'package:flutter/material.dart';
import 'package:flutter_fire/pages/posts.dart';
import 'package:flutter_fire/services/authentication.dart';
// import 'package:flutter_fire/services/jobmanagement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userIcon;
  final String username;
  final String location;
  final int salary;
  final String media;

  Post(this.userIcon, this.username, this.location, this.salary, this.media);
}

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final databaseReference = Firestore.instance;
  String userIcon =
      'https://i.pinimg.com/originals/bc/d4/ac/bcd4ac32cc7d3f98b5e54bde37d6b09e.jpg';
  bool _isLoading = false;

  List<Post> myPosts = [
    // Post(
    //     'https://i.pinimg.com/originals/bc/d4/ac/bcd4ac32cc7d3f98b5e54bde37d6b09e.jpg',
    //     'Ramesh',
    //     'Delhi',
    //     1000,
    //     'https://placetech.net/wp-content/uploads/2019/12/Construction-Site-GettyImages-936986228.jpg'),
    // Post(
    //     'https://i.pinimg.com/originals/bc/d4/ac/bcd4ac32cc7d3f98b5e54bde37d6b09e.jpg',
    //     'Rahul',
    //     'Lucknow',
    //     1500,
    //     'https://placetech.net/wp-content/uploads/2019/12/Construction-Site-GettyImages-936986228.jpg'),
  ];

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getJobList() async {
    await databaseReference
        .collection("jobs")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((el) {
        // print(el.data);
        myPosts.add(Post(el.data['createrpic'], el.data['title'],
            el.data['location'], el.data['salary'], el.data['jobpic']));
      });
    }).then((value) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) {
      print("\n\nError is: " + onError.toString());
    });
  }

  void getJobLisstUtil() async {
    await getJobList();
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    getJobList();
    super.initState();
    // getJobLisstUtil();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shramik App'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body: _isLoading
          ? _showCircularProgress()
          : myPosts != null || myPosts.isNotEmpty
              ? Container(
                  child: ListView.builder(
                      itemCount: myPosts.length,
                      itemBuilder: (context, index) {
                        return Posts(
                          post: myPosts[index],
                        );
                      }))
              : Center(
                  child: Text(
                    'No Jobs to show',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
    );
  }
}
