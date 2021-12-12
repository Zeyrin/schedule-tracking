import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:schedule_tracking/widget/container_widget.dart';

class WorkScreen extends StatefulWidget {
  WorkScreen({Key? key}) : super(key: key);

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  var location = Location();
  var lat;
  var long;
  var StartOrStop;
  String locationMessage = "";

  var buttonText = 'Start';
  var breakbuttonText = "Start Break";
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
                          if (buttonText == 'Stop') {
                            buttonText = 'Start';
                            StartOrStop = "Stopped";
                            getCurrentLocation();
                          } else {
                            buttonText = 'Stop';
                            StartOrStop = "Started";
                            getCurrentLocation();
                          }
                        });
                      },
                      child: Text(buttonText)),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (breakbuttonText == 'Stop Break') {
                            breakbuttonText = 'Started Break';
                            StartOrStop = "Stopped Break";
                            getCurrentLocation();
                          } else {
                            breakbuttonText = 'Stop Break';
                            StartOrStop = "Start Break";
                            getCurrentLocation();
                          }
                        });
                      },
                      child: Text('Break')),
                  SizedBox(height: 20),
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
            ),
          ),
        ),
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
          "$formattedDate\n$StartOrStop Working at Latitude $lat and Longitude $long";
    });
  }
}
