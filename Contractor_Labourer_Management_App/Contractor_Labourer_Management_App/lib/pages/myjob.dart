import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire/services/authentication.dart';

class Job {
  final String title;
  final String location;
  final int noOfVacancies;
  final int salary;
  final String image;

  Job(this.title, this.location, this.noOfVacancies, this.salary, this.image);
}

class MyJob extends StatefulWidget {
  @override
  _MyJobState createState() => _MyJobState();
}

class _MyJobState extends State<MyJob> {
  List<Job> myJobs = [
    // Job('Job1', 'Delhi', 20, 1000, null),
    // Job('Job2', 'Delhi', 20, 1500, null)
  ];
  bool _isLoading;
  final databaseReference = Firestore.instance;
  final Auth auth = new Auth();

  Future<void> getJobList() async {
    var user = await auth.getCurrentUser();
    await user.reload();

    databaseReference
        .collection("jobs")
        .where('createrid', isEqualTo: user.uid)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((el) {
        // print(el.data);
        myJobs.add(Job(el.data['title'], el.data['location'], el.data['worker'],
            el.data['salary'], el.data['jobpic']));
      });
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
    // getJobLisstUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Jobs'),
      ),
      body: _isLoading
          ? _showCircularProgress()
          : myJobs == null || myJobs.isEmpty
              ? Center(
                  child: Text(
                    "You haven't posted any job yet.!",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                )
              : Container(
                  color: Colors.deepOrange[50],
                  child: ListView.builder(
                    itemCount: myJobs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Container(
                          child: Card(
                            elevation: 10,
                            child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.work),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      myJobs[index].title,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.cyan,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    SizedBox(
                                      width: 150,
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  JobDetailScreen(job: myJobs[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}

class JobDetailScreen extends StatelessWidget {
  final Job job;

  JobDetailScreen({Key key, @required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          // color: Colors.cyan[50],
          elevation: 10,
          child: Container(
            color: Colors.deepOrange[50],
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: job.image != null
                        ? Container(
                            // padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Image(
                              image: NetworkImage(job.image.toString()),
                            ),
                          )
                        : Container(
                            height: 1,
                            width: 0,
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Job Location : ' + job.location,
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.cyan,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No of vacancies available : ' +
                        job.noOfVacancies.toString(),
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.cyan,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Salary : Rs' + job.salary.toString() + ' per month',
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.cyan,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// Padding(
//           padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 8),
//               child: ListView(
//                 children: <Widget>[
//                   Container(
//                       height: 70,
//                       child: Card(
//                           color: Colors.cyan[50],
//                           elevation: 10,
//                           child: ListTile(
//                               title: Text(
//                             jobOne,
//                             style: TextStyle(
//                                 fontSize: 20.0,
//                                 color: Colors.cyan,
//                                 // fontWeight: FontWeight.bold,
//                                 fontFamily: 'Montserrat'),
//                           )))),
//                   Container(
//                       height: 70,
//                       child: Card(
//                           color: Colors.cyan[50],
//                           elevation: 10,
//                           child: ListTile(
//                               title: Text(
//                             jobTwo,
//                             style: TextStyle(
//                                 fontSize: 20.0,
//                                 color: Colors.cyan,
//                                 // fontWeight: FontWeight.bold,
//                                 fontFamily: 'Montserrat'),
//                           )))),
//                   Container(
//                       height: 70,
//                       child: Card(
//                           color: Colors.cyan[50],
//                           elevation: 10,
//                           child: ListTile(
//                               title: Text(
//                             jobThree,
//                             style: TextStyle(
//                                 fontSize: 20.0,
//                                 color: Colors.cyan,
//                                 // fontWeight: FontWeight.bold,
//                                 fontFamily: 'Montserrat'),
//                           )))),
//                 ],
//               ),
//             ),
//           ),
//         ));
