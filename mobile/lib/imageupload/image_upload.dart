import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  final String? userId;
  const ImageUpload({Key? key, this.userId}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  // initializing some values
  File? _image;
  String? _request;
  final imagePicker = ImagePicker();
  String? downloadURL;

  // picking the image

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No File selected", Duration(milliseconds: 400));
      }
    });
  }

  // uploading the image to firebase cloudstore
  Future uploadImage(File _image) async {
    final imgId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('${widget.userId}/images')
        .child("post_$imgId");

    await reference.putFile(_image);
    downloadURL = await reference.getDownloadURL();

    // cloud firestore
    await firebaseFirestore
        .collection("users")
        .doc(widget.userId)
        .collection("images")
        .add({'downloadURL': downloadURL}).whenComplete(
            () => showSnackBar("File Uploaded", Duration(seconds: 2)));
  }

  // Future uploadRequest(String _request) async {
  //   final reqId = DateTime.now().millisecondsSinceEpoch.toString();
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   Reference reference = FirebaseStorage.instance
  //       .ref()
  //       .child('${widget.userId}/requests')
  //       .child("post_$reqId");

  //   await reference.putString(_request);
  //   // downloadURL = await reference.getDownloadURL();

  //   // cloud firestore
  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(widget.userId)
  //       .collection("requests")
  //       .add({'request': _request}).whenComplete(
  //           () => showSnackBar("Request posted", Duration(seconds: 2)));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload File"),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Column(children: [
                      const Text("Upload File"),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // the image that we wanted to upload
                                Expanded(
                                    child: _image == null
                                        ? const Center(
                                            child: Text("No File selected"))
                                        : Image.file(_image!)),
                                ElevatedButton(
                                    onPressed: () {
                                      imagePickerMethod();
                                    },
                                    child: const Text("Select File")),
                                ElevatedButton(
                                    onPressed: () {
                                      if (_image != null) {
                                        uploadImage(_image!);
                                      } else {
                                        showSnackBar("Select File first",
                                            Duration(milliseconds: 400));
                                      }
                                    },
                                    child: const Text("Upload File")),
                              ],
                            ),
                          ),
                        ),
                      )
                    ])))),
      ),
    );
  }

  // show snack bar

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
