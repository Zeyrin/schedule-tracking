import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/responsive.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/header.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/mini_information_card.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/recent_forums.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/recent_users.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/user_details_widget.dart';
import 'package:smart_admin_dashboard/screens/home/components/side_menu.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var isShowDeleteAccount = false;
  var isShowModifyAccount = false;
  var isShowCreateAccount = false;

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
                        setState(() {
                          isShowDeleteAccount = false;
                          isShowCreateAccount = true;
                          isShowModifyAccount = false;
                        });
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
                        },
                        child: Text("Delete user"),
                      ))
                ],
              ),
            ),
            if (isShowDeleteAccount == true) alerteDeleteAccount(),
            if (isShowCreateAccount == true) alerteCreateAccount(),
            if (isShowModifyAccount == true) alerteModifyAccount(),
          ],
        ),
      ),
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
          TextFormField(decoration: InputDecoration(hintText: "User Id")),
        ],
      ),
      actions: [
        button(
            label: "Validate",
            onTap: () {
              setState(() {
                isShowDeleteAccount = false;
              });
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
          TextFormField(decoration: InputDecoration(hintText: "User Id")),
          SizedBox(
            height: 20,
          ),
          TextFormField(decoration: InputDecoration(hintText: "User role")),
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
            decoration: InputDecoration(hintText: "User name"),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(decoration: InputDecoration(hintText: "Email")),
          SizedBox(
            height: 20,
          ),
          TextFormField(decoration: InputDecoration(hintText: "Password")),
          SizedBox(
            height: 20,
          ),
          TextFormField(decoration: InputDecoration(hintText: "User role")),
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
                isShowCreateAccount = false;
              });
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
}
