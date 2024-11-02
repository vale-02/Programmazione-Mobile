import 'package:auto_size_text/auto_size_text.dart';
import 'package:brainiac/book/book_screen.dart';
import 'package:brainiac/workplace/workplace_editexam.dart';
import 'package:brainiac/youtube/youtube_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hugeicons/hugeicons.dart';

// ignore: must_be_immutable
class WorkplaceViewexam extends StatefulWidget {
  WorkplaceViewexam(
      {super.key,
      required this.id,
      required this.name,
      required this.cfu,
      required this.status,
      required this.grade,
      required this.description,
      required this.selectedYear,
      required this.yearBox});
  Box yearBox;
  final int selectedYear;
  final int id;
  String name;
  int cfu;
  bool status;
  int grade;
  String description;

  @override
  State<WorkplaceViewexam> createState() => _WorkplaceViewexam();
}

// Pagina di visualizzazione dell'esame selezionato con il GestureDetector in ListExam
class _WorkplaceViewexam extends State<WorkplaceViewexam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: 'Museo Moderno',
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Color(0xFFFC8D0A),
              Color(0xFFFE2C8D),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: AutoSizeText(
            widget.name,
            maxLines: 2,
            minFontSize: 13,
            stepGranularity: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _editExamScreen(context);
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedPencilEdit02,
              color: Color(0xFFFC8D0A),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        widget.cfu.toString(),
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
                    widget.status
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
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Descrizione :',
                style: TextStyle(
                  color: Color(0xFFFE2C8D),
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(17.0),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Museo Moderno',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            YoutubeScreen(searchName: widget.name),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedYoutube,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Video',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Museo Moderno',
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            BookScreen(searchName: widget.name),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedBookBookmark02,
                        color: Colors.blue,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Libri',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Museo Moderno',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStatus() {
    return widget.status ? 'Superato' : 'In corso';
  }

  String _getGrade() {
    return widget.grade == 0 ? '' : widget.grade.toString();
  }

  // Funzione per la modifica dell'esame che si sta vedendo e aggiornamento dei dati relativi ad esso
  void _editExamScreen(BuildContext context) async {
    final updatedValues = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkplaceEditexam(
          yearBox: widget.yearBox,
          year: widget.selectedYear,
          id: widget.id,
          name: widget.name,
          cfu: widget.cfu,
          status: widget.status,
          grade: widget.grade,
          description: widget.description,
        ),
      ),
    );

    if (updatedValues != null) {
      setState(() {
        widget.name = updatedValues['name'] ?? widget.name;
        widget.cfu = updatedValues['cfu'] ?? widget.cfu;
        widget.status = updatedValues['status'] ?? widget.status;
        widget.grade = updatedValues['grade'] ?? widget.grade;
        widget.description = updatedValues['description'] ?? widget.description;
      });
    }
  }
}
