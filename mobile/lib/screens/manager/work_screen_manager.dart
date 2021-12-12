import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:schedule_tracking/widget/container_widget.dart';

class WorkScreenManager extends StatefulWidget {
  WorkScreenManager({Key? key}) : super(key: key);

  @override
  _WorkScreenManagerState createState() => _WorkScreenManagerState();
}

class _WorkScreenManagerState extends State<WorkScreenManager> {
  var location = Location();
  var lat;
  var long;
  var StartOrStop;
  String locationMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
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
                      onPressed: () {
                        StartOrStop = "Started";
                        getCurrentLocation();
                      },
                    ),
                    height: 60,
                    width: 100,
                  ),
                  SimpleContainer(
                    child: IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: () {
                        StartOrStop = "Stopped";
                        getCurrentLocation();
                      },
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
              ),
              SimpleContainer(
                child: Center(
                  child: Text(
                    locationMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                height: 140,
                width: 400,
              ),
            ],
          ),
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

  void getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    var currentlocation = await location.getLocation();
    long = currentlocation.longitude;
    lat = currentlocation.latitude;
    long = long.toStringAsFixed(2);

    lat = lat.toStringAsFixed(2);

    setState(() {
      locationMessage =
          "Date :  $formattedDate\n\n$StartOrStop Working at Latitude $lat \nand Longitude $long";
    });
  }
}
