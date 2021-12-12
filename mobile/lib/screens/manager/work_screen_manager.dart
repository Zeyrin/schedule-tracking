import 'package:flutter/material.dart';
import 'package:schedule_tracking/widget/container_widget.dart';

class WorkScreenManager extends StatefulWidget {
  WorkScreenManager({Key? key}) : super(key: key);

  @override
  _WorkScreenManagerState createState() => _WorkScreenManagerState();
}

class _WorkScreenManagerState extends State<WorkScreenManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'WorkTime',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SimpleContainer(
                child: IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {},
                ),
                height: 60,
                width: 100,
              ),
              SimpleContainer(
                child: Text(
                  'Break',
                  style: TextStyle(fontSize: 20),
                ),
                height: 60,
                width: 100,
              )
            ],
          ),
          SimpleContainer(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'User: Maceo',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  'Request:\nDays off for christmas\n(20/12 - 03/01)',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buttonWidget(
                        label: 'Accept',
                        color: Colors.greenAccent,
                        onTap: () {},
                        height: 50,
                        width: 100,
                      ),
                      buttonWidget(
                        label: 'Deny',
                        color: Colors.redAccent,
                        onTap: () {},
                        height: 50,
                        width: 100,
                      ),
                    ],
                  ),
                ),
                buttonWidget(
                  label: 'Delegate',
                  color: Colors.blueAccent,
                  onTap: () {},
                  height: 50,
                  width: 100,
                )
              ],
            ),
            height: 400,
            width: 400,
          )
        ],
      ),
    );
  }

  Widget buttonWidget({
    required String label,
    required Color color,
    required Function onTap,
    required double height,
    required double width,
  }) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Align(alignment: Alignment.center, child: Text(label)),
      ),
    );
  }
}
