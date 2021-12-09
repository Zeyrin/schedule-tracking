import 'package:flutter/material.dart';

class WorkScreen extends StatefulWidget {
  WorkScreen({Key? key}) : super(key: key);

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  var buttonText = 'Start';
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
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (buttonText == 'Stop')
                            buttonText = 'Start';
                          else
                            buttonText = 'Stop';
                        });
                      },
                      child: Text(buttonText)),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: () {}, child: Text('Break')),
                  SizedBox(height: 20),
                  Text("You have got a message")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
