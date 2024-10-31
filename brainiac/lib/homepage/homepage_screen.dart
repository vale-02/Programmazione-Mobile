import 'package:brainiac/homepage/widget/decoration.dart';
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
          DecorationsCircle(),
          Transform.translate(
            offset:
                const Offset(-60, -120), // Sposta l'icona in alto e a sinistra
            child: Transform.rotate(
              angle:
                  -0.3, // Rotazione in radianti (es. -0.1 è circa -5.7 gradi)
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedLaurelWreath01,
                color: Colors.white,
                size: 80,
              ),
            ),
          ),
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
