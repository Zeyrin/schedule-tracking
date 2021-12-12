import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schedule_tracking/models/user_model.dart';
import 'package:schedule_tracking/screens/login_screen.dart';
import 'package:schedule_tracking/widget/container_widget.dart';

class ProfileScreenManager extends StatefulWidget {
  const ProfileScreenManager({Key? key}) : super(key: key);

  @override
  _ProfileScreenManagerState createState() => _ProfileScreenManagerState();
}

class _ProfileScreenManagerState extends State<ProfileScreenManager> {
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 30),
                )),
            SimpleContainer(
              child: Text("Username: " + loggedInUser.firstName.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  )),
              height: 70,
              width: 150,
            ),
            SimpleContainer(
              child: Text("Manager: " + loggedInUser.manager.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  )),
              height: 70,
              width: 150,
            ),
            SimpleContainer(
              child:
                  Text("Managed Users: " + loggedInUser.managedUsers.toString(),
                      style: TextStyle(
                        color: Colors.white,
                      )),
              height: 70,
              width: 150,
            ),
            SimpleContainer(
              child: Text("Off Days left : " + loggedInUser.days.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  )),
              height: 70,
              width: 180,
            ),
            ActionChip(
                label: Text("Logout"),
                onPressed: () {
                  logout(context);
                }),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
