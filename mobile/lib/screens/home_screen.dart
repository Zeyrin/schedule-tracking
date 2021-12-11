// // ignore_for_file: prefer_const_literals_to_create_immutables

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:schedule_tracking/models/user_model.dart';
// import 'package:schedule_tracking/screens/manager/home_screen_manager.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel loggedInUser = UserModel();
//   TextEditingController requestController = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(user!.uid)
//         .get()
//         .then((value) {
//       this.loggedInUser = UserModel.fromMap(value.data());

//       setState(() {});
//     });
//   }

//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 5,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Schedule Tracking App"),
//           centerTitle: true,
//           // leading: IconButton(
//           //   icon: Icon(Icons.menu),
//           //   onPressed: () {},
//           // ),
//           // actions: [
//           //   IconButton(
//           //     icon: Icon(Icons.notifications_none),
//           //     onPressed: () {},
//           //   )
//           // ],
//           backgroundColor: Colors.indigoAccent,
//           elevation: 20,
//           bottom: const TabBar(
//             indicatorColor: Colors.white,
//             indicatorWeight: 5,
//             tabs: [
//               Tab(icon: Icon(Icons.calendar_today), text: 'Calendar'),
//               Tab(icon: Icon(Icons.bar_chart), text: 'Statistics'),
//               Tab(icon: Icon(Icons.timer), text: 'Work'),
//               Tab(icon: Icon(Icons.person), text: 'Profile'),
//               Tab(icon: Icon(Icons.upload), text: 'Upload'),
//             ],
//           ),
//         ),
//         body: checkRole(loggedInUser),
//       ),
//     );
//   }

//   Widget buildPage() => Center(
//         child: ElevatedButton(
//           onPressed: () {},
//           child: Text('Lol'),
//         ),
//       );


// }
