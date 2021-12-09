import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({Key? key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  var buttonText = 'Day';
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
                          if (buttonText == 'Day')
                            buttonText = 'Week';
                          else if (buttonText == 'Week')
                            buttonText = 'Month';
                          else
                            buttonText = 'Day';
                        });
                      },
                      child: Text(buttonText)),
                  SizedBox(height: 20),
                  Text("Calendar")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
