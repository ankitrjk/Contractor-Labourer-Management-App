import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_fire/services/jobmanagement.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadPost extends StatefulWidget {
  @override
  _UploadPostState createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  final _formKey = GlobalKey<FormState>();
  final myControllerJobTitle = TextEditingController();
  final myControllerjobLocation = TextEditingController();
  final myControllernoOfJobs = TextEditingController();
  final myControllerSalary = TextEditingController();

  String jobTitle,
      jobLocation,
      jobStatus = "Wait...",
      jobPicUrl =
          'https://placetech.net/wp-content/uploads/2019/12/Construction-Site-GettyImages-936986228.jpg';
  int noOfJobs, salary;
  File selectedImage;
  bool _isLoading = false;
  final jobManager = new JobManagement();

  Future selectPhoto() async {
    setState(() {
      _isLoading = true;
    });
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = tempImage;
      _isLoading = false;
      // uploadImage();
    });
  }

  void uploadJobUtil(context) async {
    await uploadImage(context);
  }

  Future uploadImage(context) async {
    setState(() {
      _isLoading = true;
    });

    var randomno = Random(TimeOfDay.now().minute);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('jobpics/${randomno.nextInt(500000).toString()}.jpg');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(selectedImage);
    await uploadTask.onComplete;
    print('File Uploaded.!');

    var user = await auth.getCurrentUser();
    await user.reload();
    firebaseStorageRef.getDownloadURL().then((picUrl) {
      setState(() {
        jobPicUrl = picUrl.toString();
      });
      jobManager.createJob({
        'createrid': user.uid,
        'createrpic': user.photoUrl.toString(),
        'title': jobTitle,
        'location': jobLocation,
        'worker': noOfJobs,
        'salary': salary,
        'jobpic': jobPicUrl
      }).then((id) {
        setState(() {
          jobStatus += "\nDone JobId :" + id.toString();
          _formKey.currentState.reset();
          _isLoading = false;
          Navigator.of(context).pushReplacementNamed('/homepage');
        });
      }).catchError((e) {
        setState(() {
          jobStatus = 'Cannot Post job, tech.issue';
          _isLoading = false;
        });
      });
    }).catchError((onError) {
      print(onError.toString());
      setState(() {
        jobStatus = 'Cannot Post job, tech.issue';
        _isLoading = false;
      });
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Create Job"),
        ),
        body: Center(
            child: Card(
                child: SingleChildScrollView(
                    child: Container(
                        color: Colors.deepOrange[50],
                        child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: myControllerJobTitle,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Job Title',
                                        labelText: 'Job Title',
                                      ),
                                      onSaved: (String value) {},
                                      onChanged: (String value) {},
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: myControllerjobLocation,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Job Location',
                                        labelText: 'Job Location',
                                      ),
                                      onSaved: (String value) {},
                                      onChanged: (String value) {},
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: myControllernoOfJobs,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter No of People required',
                                        labelText: 'No of vacancies',
                                      ),
                                      onSaved: (value) {},
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: myControllerSalary,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Salary in Rs',
                                        labelText: 'Salary',
                                      ),
                                      onSaved: (value) {},
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  _showCircularProgress(),
                                  selectedImage == null
                                      ? Icon(
                                          Icons.add_a_photo,
                                          size: 50,
                                        )
                                      : Image.file(
                                          selectedImage,
                                          height: 150,
                                          width: 150,
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Container(
                                  //   height: 40,
                                  //   child: (RaisedButton(
                                  //     color: Colors.cyan,
                                  //     onPressed: () async {
                                  //       var tempImage =
                                  //           await ImagePicker.pickImage(
                                  //               source: ImageSource.gallery);
                                  //       setState(() {
                                  //         selectedImage = tempImage;
                                  //       });
                                  //       Container(
                                  //         height: 0,
                                  //         width: 1,
                                  //       );
                                  //     },
                                  //     child: Text(
                                  //       'Select Picture',
                                  //       style: TextStyle(
                                  //           fontSize: 20,
                                  //           fontFamily: 'Montserrat'),
                                  //     ),
                                  //   )),
                                  // ),
                                  Container(
                                      height: 30.0,
                                      width: 95.0,
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        shadowColor: Colors.blueAccent,
                                        color: Colors.blue,
                                        elevation: 7.0,
                                        child: GestureDetector(
                                          onTap: selectPhoto,
                                          child: Center(
                                            child: Text(
                                              'select Photo',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                          ),
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 20),
                                      child: Container(
                                          // color: Colors.deepOrangeAccent,
                                          height: 60,
                                          child: RaisedButton(
                                              color: Colors.deepOrangeAccent,
                                              child: Text(
                                                "Create Job",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontFamily: 'Montserrat'),
                                              ),
                                              onPressed: () {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  _formKey.currentState.save();
                                                }
                                                setState(() {
                                                  _isLoading = true;
                                                  jobTitle =
                                                      myControllerJobTitle.text;
                                                  jobLocation =
                                                      myControllerjobLocation
                                                          .text;
                                                  noOfJobs = int.parse(
                                                      myControllernoOfJobs
                                                          .text);
                                                  salary = int.parse(
                                                      myControllerSalary.text);
                                                });
                                                uploadJobUtil(context);
                                                showDialog(
                                                  context: context,
                                                  child: new AlertDialog(
                                                      title: new Text(
                                                    jobStatus,
                                                  )),
                                                );
                                              }))),
                                ])))))));
  }
}

// class _UploadPostState extends State<UploadPost> {
//   File selectedImage;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           selectedImage == null
//               ? Icon(
//                   Icons.add_a_photo,
//                   size: 50,
//                 )
//               : Image.file(
//                   selectedImage,
//                   height: 300,
//                   width: 300,
//                 ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: 50,
//             child: (RaisedButton(
//               color: Colors.cyan,
//               onPressed: () async {
//                 var tempImage =
//                     await ImagePicker.pickImage(source: ImageSource.gallery);
//                 setState(() {
//                   selectedImage = tempImage;
//                 });
//               },
//               child: Text(
//                 'Select Picture',
//                 style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
//               ),
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }
