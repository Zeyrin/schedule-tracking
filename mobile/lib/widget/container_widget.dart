import 'package:flutter/material.dart';

class SimpleContainer extends StatelessWidget {
  const SimpleContainer({
    Key? key,
    required this.child,
    required this.height,
    required this.width,
  }) : super(key: key);
  final double height;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Align(alignment: Alignment.center, child: child),
      ),
    );
  }
}
