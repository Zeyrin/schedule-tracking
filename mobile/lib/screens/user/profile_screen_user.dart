import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:schedule_tracking/models/user_model.dart';
import 'package:schedule_tracking/screens/login_screen.dart';
import 'package:schedule_tracking/screens/manager/home_screen_manager.dart';
import 'package:schedule_tracking/widget/container_widget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var buttonText = 'Day';

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    // TODO: implement initState
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

  @override
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
                  // TextButton(
                  //   onPressed: () => showDialog<String>(
                  //     context: context,
                  //     builder: (BuildContext context) => AlertDialog(
                  //       title: const Text('Make a request'),
                  //       content: const TextField(),
                  //       actions: <Widget>[
                  //         TextButton(
                  //           onPressed: () => Navigator.pop(context, 'Cancel'),
                  //           child: const Text('Cancel'),
                  //         ),
                  //         TextButton(
                  //           onPressed: () => Navigator.pop(context, 'OK'),
                  //           child: const Text('Make request'),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   child: const Text('Make request'),
                  // ),
                  Text("Welcome"),
                  Text("${loggedInUser.firstName}"),
                  Text("${loggedInUser.secondName}"),
                  SimpleContainer(
                    child:
                        Text("Off Days left : " + loggedInUser.days.toString()),
                    height: 70,
                    width: 180,
                  ),
                  ActionChip(
                      label: Text("Manager mode"),
                      onPressed: () {
                        checkRole(loggedInUser);
                      }),
                  ActionChip(
                      label: Text("Logout"),
                      onPressed: () {
                        logout(context);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  checkRole(UserModel loggedInUser) {
    if (loggedInUser.role.toString() == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (loggedInUser.role.toString() == 'manager') {
      Fluttertoast.showToast(msg: "Welcome to manager mode");

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreenManager()));
    } else {
      Fluttertoast.showToast(msg: "You are not a manager");
    }
  }
}
