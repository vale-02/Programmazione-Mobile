import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DetailsExam extends StatelessWidget {
  const DetailsExam({
    super.key,
    required this.cfu,
    required this.status,
    required this.grade,
  });
  final int cfu;
  final bool status;
  final int grade;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                cfu.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ),
            Text(
              'CFU',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Museo Moderno',
              ),
            )
          ],
        ),
        Column(
          children: [
            status
                ? HugeIcon(
                    icon: HugeIcons.strokeRoundedCheckmarkBadge02,
                    color: Colors.lightGreenAccent,
                    size: 40,
                  )
                : HugeIcon(
                    icon: HugeIcons.strokeRoundedLoading02,
                    color: Colors.lightBlueAccent,
                    size: 40,
                  ),
            Text(
              _getStatus(),
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Museo Moderno',
              ),
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFFC8D0A),
              child: Text(
                _getGrade(),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ),
            Text(
              'Voto',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Museo Moderno',
              ),
            ),
          ],
        )
      ],
    );
  }

  String _getStatus() {
    return status ? 'Superato' : 'In corso';
  }

  String _getGrade() {
    return grade == 0 ? '' : grade.toString();
  }
}
