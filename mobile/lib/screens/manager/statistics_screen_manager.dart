import 'package:flutter/material.dart';

class StatisticsScreenManager extends StatefulWidget {
  StatisticsScreenManager({Key? key}) : super(key: key);

  @override
  _StatisticsScreenManagerState createState() =>
      _StatisticsScreenManagerState();
}

class _StatisticsScreenManagerState extends State<StatisticsScreenManager> {
  String buttonText = 'Day';
  List<String> people = ['Maceo', 'Olivier', 'Gianni', 'Benjamin'];
  int listIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Statistical',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Filtered by'),
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
              ],
            ),
            Row(
              children: [
                Text('Person'),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (listIndex < people.length - 1)
                          listIndex += 1;
                        else
                          listIndex = 0;
                      });
                    },
                    child: Text(people[listIndex])),
              ],
            ),
            SizedBox(height: 20),
            Text("Statistical")
          ],
        ),
      ),
    );
  }
}
