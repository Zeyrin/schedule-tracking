// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:schedule_tracking/screens/user/file_picker.dart';
import 'package:schedule_tracking/screens/user/profile_screen_user.dart';
import 'package:schedule_tracking/screens/user/statistics_screen_user.dart';
import 'package:schedule_tracking/screens/user/upload_screen.dart';
import 'package:schedule_tracking/screens/user/work_screen_user.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Schedule Tracking App"),
          centerTitle: true,
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: () {},
          // ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.notifications_none),
          //     onPressed: () {},
          //   )
          // ],
          backgroundColor: Colors.indigoAccent,
          elevation: 20,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(Icons.calendar_today), text: 'Calendar'),
              Tab(icon: Icon(Icons.bar_chart), text: 'Statistics'),
              Tab(icon: Icon(Icons.timer), text: 'Work'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
              Tab(icon: Icon(Icons.upload), text: 'Upload'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 562,
                    child: TabBarView(children: [
                      FilePickerDemo(),
                      StatisticsScreen(),
                      WorkScreen(),
                      ProfileScreen(),
                      UploadScreen(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPage() => Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Lol'),
        ),
      );
}
