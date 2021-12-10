import 'package:flutter/material.dart';
import 'package:schedule_tracking/widget/container_widget.dart';

class ProfileScreenManager extends StatefulWidget {
  const ProfileScreenManager({Key? key}) : super(key: key);

  @override
  _ProfileScreenManagerState createState() => _ProfileScreenManagerState();
}

class _ProfileScreenManagerState extends State<ProfileScreenManager> {
  @override
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
              child: Text("Username: Benjamin"),
              height: 70,
              width: 150,
            ),
            SimpleContainer(
              child: Text("Username: Benjamin"),
              height: 70,
              width: 150,
            ),
            GestureDetector(
              onTap: () {
                //do action
                print("j'ai cliqué");
              },
              child: SimpleContainer(
                child: Text("clique dessus "),
                height: 70,
                width: 150,
              ),
            ),
            SimpleContainer(
              child: Text("Remaining off days: 31"),
              height: 70,
              width: 180,
            ),
          ],
        ),
      ),
    );
  }
}
