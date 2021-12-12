import 'package:flutter/material.dart';
import 'package:location/location.dart';

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

  void getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    DateTime now = DateTime.now();

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
    setState(() {
      locationMessage =
          "$now\n$StartOrStop Working at Latitude $lat and Longitude $long";
    });
  }

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
                            StartOrStop = "Stop";
                            getCurrentLocation();
                          } else {
                            buttonText = 'Stop';
                            StartOrStop = "Start";
                            getCurrentLocation();
                          }
                        });
                      },
                      child: Text(buttonText)),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      if (breakbuttonText == 'Stop Break') {
                        breakbuttonText = 'Start Break';
                        StartOrStop = "Stop Break";
                        getCurrentLocation();
                      } else {
                        breakbuttonText = 'Stop Break';
                        StartOrStop = "Start Break";
                        getCurrentLocation();
                      }
                    });
                  }, child: Text('Break')),
                  SizedBox(height: 20),
                  Text(
                    locationMessage,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
