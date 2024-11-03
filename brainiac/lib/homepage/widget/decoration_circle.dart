import 'package:flutter/material.dart';

class DecorationsCircle extends StatelessWidget {
  const DecorationsCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment(-0.8, 0.3),
          child: Container(
            width: 8,
            height: 8,
            decoration: const ShapeDecoration(
              color: Color(0xFFFE2C8D),
              shape: OvalBorder(),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.4, 0.37),
          child: Container(
            width: 7,
            height: 7,
            decoration: const ShapeDecoration(
              color: Color(0xFFF1791D),
              shape: OvalBorder(),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.55, -0.27),
          child: Container(
            width: 7,
            height: 7,
            decoration: const ShapeDecoration(
              color: Color(0xFFF24069),
              shape: OvalBorder(),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.4, -0.35),
          child: Container(
            width: 7,
            height: 7,
            decoration: const ShapeDecoration(
              color: Color(0xFFFC8D0A),
              shape: OvalBorder(),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.35, 0.42),
          child: Container(
            width: 7,
            height: 7,
            decoration: const ShapeDecoration(
              color: Color(0xFFFE2C8D),
              shape: OvalBorder(),
            ),
          ),
        ),
        Align(
          alignment: Alignment(-0.6, -0.2),
          child: Container(
            width: 10,
            height: 10,
            decoration: const ShapeDecoration(
              color: Color(0xFFED4F52),
              shape: OvalBorder(),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.9, -0.1),
          child: Container(
            width: 10,
            height: 10,
            decoration: const ShapeDecoration(
              color: Color(0xFFFE2C8D),
              shape: OvalBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
