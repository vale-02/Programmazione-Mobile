import 'package:brainiac/homepage/widget/decoration_circle.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:flutter_gradient_text/flutter_gradient_text.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: RadialGradient(
        radius: 0.7,
        colors: [
          Color.fromARGB(255, 66, 66, 66),
          Color(0xFF000000),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Titolo HomePage
          GradientText(
            Text(
              'Brainiac',
              style: TextStyle(
                fontSize: 58,
                fontFamily: 'Museo Moderno',
              ),
            ),
            colors: [
              Color(0xFFFC8D0A),
              Color(0xFFFE2C8D),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          // Decorazioni
          DecorationsCircle(),
          // Icona laurea
          Transform.translate(
            offset: const Offset(-60, -120),
            child: Transform.rotate(
              angle: -0.3,
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedLaurelWreath01,
                color: Colors.white,
                size: 80,
              ),
            ),
          ),
          // Scritta con freccia per dire all'utente cosa fare
          Column(
            verticalDirection: VerticalDirection.up,
            children: [
              SizedBox(
                height: 10,
              ),
              HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowUp01,
                  color: Colors.white,
                  size: 25),
              SizedBox(
                height: 8,
              ),
              Text(
                'Scorri verso l\'alto per accedere',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
