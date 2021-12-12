import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_admin_dashboard/models/user_model.dart';
import 'package:smart_admin_dashboard/screens/home/components/side_menu.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController managerController = TextEditingController();
  final TextEditingController daysController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  String? uid;
  String? userEmail;

  final _formKey = GlobalKey<FormState>();

  var isShowDeleteAccount = false;
  var isShowModifyAccount = false;
  var isShowCreateAccount = false;

  List<String> userNames = [
    "Benjamin",
    "Gianni",
    "Maceo",
    "Olivier",
  ];
  List<String> userIds = [
    "9Y8Y87988",
    "3457988988",
    "086R4567866",
    "9853567964",
  ];

  List<String> userEmails = [
    "benjamin@flutter3.com",
    "gianni@flutter3.com",
    "maceo@flutter3.com",
    "Olivier@flutter3.com",
  ];
  List<String> userRoles = [
    "user",
    "user",
    "admin",
    "manager",
  ];

  @override
  void initState() {
    super.initState();
    isShowDeleteAccount = false;
    isShowModifyAccount = false;
    isShowCreateAccount = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 50,
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(
                          () {
                            isShowDeleteAccount = false;
                            isShowCreateAccount = true;
                            isShowModifyAccount = false;
                          },
                        );
                        emailController.text = "";
                        passwordController.text = "";
                        userIdController.text = "";
                        firstNameController.text = "";
                        daysController.text = "";
                        managerController.text = "";
                        roleController.text = "";
                      },
                      child: Text("Create user"),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 50,
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isShowDeleteAccount = false;
                            isShowCreateAccount = false;
                            isShowModifyAccount = true;
                          });
                          emailController.text = "";
                          passwordController.text = "";
                          userIdController.text = "";
                          firstNameController.text = "";
                          daysController.text = "";
                          managerController.text = "";
                          roleController.text = "";
                        },
                        child: Text("Modify user"),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 50,
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isShowDeleteAccount = true;
                            isShowCreateAccount = false;
                            isShowModifyAccount = false;
                          });
                          emailController.text = "";
                          passwordController.text = "";
                          userIdController.text = "";
                          firstNameController.text = "";
                          daysController.text = "";
                          managerController.text = "";
                          roleController.text = "";
                        },
                        child: Text("Delete user"),
                      ))
                ],
              ),
            ),
            if (isShowDeleteAccount == true) alerteDeleteAccount(),
            if (isShowCreateAccount == true) alerteCreateAccount(),
            if (isShowModifyAccount == true) alerteModifyAccount(),
            Expanded(
              child: Container(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  itemCount: userNames.length,
                  itemBuilder: (BuildContext context, int userIndex) {
                    final userName = userNames[userIndex];
                    final userId = userIds[userIndex];
                    final userRole = userRoles[userIndex];
                    final userEmail = userEmails[userIndex];

                    return userListItem(
                        name: userName,
                        role: userRole,
                        email: userEmail,
                        id: userId);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userListItem(
      {required String name,
      required String role,
      required String email,
      required String id}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          role,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          id,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          email,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget button(
      {required String label,
      required void Function() onTap,
      required Color color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(label),
        ),
      ),
    );
  }

  Widget alerteDeleteAccount() {
    return AlertDialog(
      title: Text("Delete user Account"),
      content: Column(
        children: [
          TextFormField(
              controller: userIdController,
              onSaved: (value) {
                userIdController.text = value!;
              },
              decoration: InputDecoration(hintText: "User Id")),
        ],
      ),
      actions: [
        button(
            label: "Validate",
            onTap: () {
              setState(() {
                isShowDeleteAccount = false;
              });
              deleteUid(userIdController.text);
            },
            color: Colors.green),
        SizedBox(
          height: 5,
        ),
        button(
            label: "Cancel",
            onTap: () {
              setState(() {
                isShowDeleteAccount = false;
              });
            },
            color: Colors.red),
      ],
    );
  }

  Widget alerteModifyAccount() {
    return AlertDialog(
      title: Text("Modify user account"),
      content: Column(
        children: [
          TextFormField(
              controller: userIdController,
              onSaved: (value) {
                userIdController.text = value!;
              },
              decoration: InputDecoration(hintText: "User Id")),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: "Email"),
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Email");
              }
              // reg expression for email validation
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please Enter a valid email");
              }
              return null;
            },
            onSaved: (value) {
              emailController.text = value!;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(hintText: "First Name"),
            onSaved: (value) {
              firstNameController.text = value!;
            },
          ),
          TextFormField(
            controller: daysController,
            decoration: InputDecoration(hintText: "Days off"),
            onSaved: (value) {
              daysController.text = value!;
            },
          ),
          TextFormField(
            controller: managerController,
            decoration: InputDecoration(hintText: "Manger Name"),
            onSaved: (value) {
              managerController.text = value!;
            },
          ),
          TextFormField(
              controller: roleController,
              onSaved: (value) {
                roleController.text = value!;
              },
              decoration: InputDecoration(hintText: "User role")),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      actions: [
        button(
            label: "Validate",
            onTap: () {
              setState(() {
                isShowModifyAccount = false;
              });
              postDetailsUid(userIdController.text);
            },
            color: Colors.green),
        SizedBox(
          height: 5,
        ),
        button(
            label: "Cancel",
            onTap: () {
              setState(() {
                isShowModifyAccount = false;
              });
            },
            color: Colors.red),
      ],
    );
  }

  Widget alerteCreateAccount() {
    return AlertDialog(
      title: Text("Create account"),
      content: Column(
        children: [
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(
              hintText: "User name",
            ),
            validator: (value) {
              RegExp regex = new RegExp(r'^.{3,}$');
              if (value!.isEmpty) {
                return ("First Name cannot be Empty");
              }
              if (!regex.hasMatch(value)) {
                return ("Enter Valid name(Min. 3 Character)");
              }
              return null;
            },
            onSaved: (value) {
              firstNameController.text = value!;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: "Email"),
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Email");
              }
              // reg expression for email validation
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please Enter a valid email");
              }
              return null;
            },
            onSaved: (value) {
              emailController.text = value!;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(hintText: "Password"),
            obscureText: true,
            validator: (value) {
              RegExp regex = new RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return ("Password is required for login");
              }
              if (!regex.hasMatch(value)) {
                return ("Enter Valid Password(Min. 6 Character)");
              }
            },
            onSaved: (value) {
              passwordController.text = value!;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: roleController,
            decoration: InputDecoration(hintText: "User role"),
            onSaved: (value) {
              roleController.text = value!;
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      actions: [
        button(
            label: "Validate",
            onTap: () {
              signUp(emailController.text, passwordController.text);
              setState(() {
                isShowCreateAccount = false;
              });
              firstNameController.text = "";
              emailController.text = "";
              passwordController.text = "";
              // roleController.text = "";
            },
            color: Colors.green),
        SizedBox(
          height: 5,
        ),
        button(
            label: "Cancel",
            onTap: () {
              setState(() {
                isShowCreateAccount = false;
              });
            },
            color: Colors.red),
      ],
    );
  }

  Future<User?> registerWithEmailPassword(String email, String password) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.days = "31";
    userModel.manager = "Benjamin";
    userModel.role = roleController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }

  postDetailsUid(String Uid) async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = emailController.text;
    userModel.uid = userIdController.text;
    userModel.firstName = firstNameController.text;
    userModel.days = daysController.text;
    userModel.manager = managerController.text;
    userModel.role = roleController.text;

    await firebaseFirestore.collection("users").doc(Uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }

  deleteUid(String Uid) async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // // writing all the values
    // userModel.email = emailController.text;
    // userModel.uid = userIdController.text;
    // userModel.firstName = firstNameController.text;
    // userModel.days = daysController.text;
    // userModel.manager = managerController.text;
    // userModel.role = roleController.text;

    await firebaseFirestore.collection("users").doc(Uid).delete();
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }

  void signUp(String email, String password) async {
    // try {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
    //   // } on FirebaseAuthException catch (error) {
    //   //   switch (error.code) {
    //   //     case "invalid-email":
    //   //       errorMessage = "Your email address appears to be malformed.";
    //   //       break;
    //   //     case "wrong-password":
    //   //       errorMessage = "Your password is wrong.";
    //   //       break;
    //   //     case "user-not-found":
    //   //       errorMessage = "User with this email doesn't exist.";
    //   //       break;
    //   //     case "user-disabled":
    //   //       errorMessage = "User with this email has been disabled.";
    //   //       break;
    //   //     case "too-many-requests":
    //   //       errorMessage = "Too many requests";
    //   //       break;
    //   //     case "operation-not-allowed":
    //   //       errorMessage = "Signing in with Email and Password is not enabled.";
    //   //       break;
    //   //     default:
    //   //       errorMessage = "An undefined Error happened.";
    //   //   }
    //   //   Fluttertoast.showToast(msg: errorMessage!);
    //   //   print(error.code);
    //   // }
  }

  void signIn(String email, String password) async {
    // try {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}
