import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:schedule_tracking/imageupload/image_retrive.dart';
import 'package:schedule_tracking/imageupload/image_upload.dart';
import 'package:schedule_tracking/models/user_model.dart';

class UploadScreen extends StatefulWidget {
  final String? userId;

  UploadScreen({Key? key, this.userId}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  TextEditingController requestController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageUpload(
                                      userId: loggedInUser.uid,
                                    )));
                      },
                      child: Text("Upload")),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ImageRetrive(userId: loggedInUser.uid)));
                      },
                      child: Text('Show')),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Make a request'),
                                  content: TextField(
                                    controller: requestController,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (requestController != null) {
                                            uploadRequest(
                                                requestController.toString());
                                          } else {
                                            showSnackBar("Select Image first",
                                                Duration(milliseconds: 400));
                                          }
                                        },
                                        child: const Text("Upload Request")),
                                  ],
                                ));
                      },
                      child: Text('Make request')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future uploadRequest(String _request) async {
    final reqId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('${widget.userId}/requests')
        .child("post_$reqId");

    await reference.putString(_request);
    // downloadURL = await reference.getDownloadURL();

    // cloud firestore
    await firebaseFirestore
        .collection("users")
        .doc(widget.userId)
        .collection("requests")
        .add({'request': _request}).whenComplete(
            () => showSnackBar("Request posted", Duration(seconds: 2)));
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
