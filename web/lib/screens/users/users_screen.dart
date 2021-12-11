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
  bool isShowDeleteAccount = false;

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
                    child: button(
                        label: "Add user", onTap: () {}, color: Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 50,
                    ),
                    child: button(
                        label: "Edit user", onTap: () {}, color: Colors.orange),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 50,
                    ),
                    child: button(
                        label: "Delete user",
                        onTap: () {
                          setState(() {
                            isShowDeleteAccount = true;
                          });
                        },
                        color: Colors.red),
                  )
                ],
              ),
            ),
            if (isShowDeleteAccount == true) alerteDeleteAccount()
          ],
        ),
      ),
    );
  }

  Widget button(
      {required String label, required Function onTap, required Color color}) {
    return InkWell(
      onTap: onTap(),
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
          Text("User Id"),
          TextFormField(),
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
}
