import 'package:flutter/material.dart';
import 'package:flutter_fire/pages/dashboard.dart';

class Posts extends StatefulWidget {
  final Post post;
  Posts({Key key, @required this.post}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange[50],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Center(
          child: Card(
            elevation: 10,
            // color: Colors.cyan[100],
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(widget.post.userIcon),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.post.username,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                        SizedBox(width: 30),
                        Icon(Icons.location_on),
                        Text(
                          widget.post.location,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Container(
                      // padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Image(
                        image: NetworkImage(widget.post.media),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: Text(
                      'Salary : Rs' +
                          widget.post.salary.toString() +
                          ' per month',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: (RaisedButton(
                      color: Colors.cyan,
                      onPressed: () {},
                      child: Text(
                        'Send Request',
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
