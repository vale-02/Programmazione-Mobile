import 'package:brainiac/workplace/workplace_editexam.dart';
import 'package:flutter/material.dart';

class WorkplaceViewexam extends StatefulWidget {
  WorkplaceViewexam(
      {super.key,
      required this.id,
      required this.name,
      required this.cfu,
      required this.status,
      required this.grade,
      required this.description});
  final int id;
  String name;
  int cfu;
  bool status;
  int grade;
  String description;

  @override
  State<WorkplaceViewexam> createState() => _WorkplaceViewexam();
}

class _WorkplaceViewexam extends State<WorkplaceViewexam> {
  String _getStatus() {
    return widget.status ? 'Superato' : 'In corso';
  }

  String _getGrade() {
    return widget.grade == 0 ? '' : widget.grade.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      final updatedValues = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WorkplaceEditexam(
                            id: widget.id,
                            name: widget.name,
                            cfu: widget.cfu,
                            status: widget.status,
                            grade: widget.grade,
                            description: widget.description,
                          ),
                        ),
                      );

                      setState(() {
                        widget.name = updatedValues['name'];
                        widget.cfu = updatedValues['cfu'];
                        widget.status = updatedValues['status'];
                        widget.grade = updatedValues['grade'];
                        widget.description = updatedValues['description'];
                      });
                    },
                    icon: Icon(Icons.edit)),
                SizedBox(
                  width: 20,
                ),
                Text(widget.name),
                SizedBox(
                  width: 20,
                ),
                Text(_getGrade()),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('CFU: ${widget.cfu.toString()}'),
                SizedBox(
                  width: 50,
                ),
                Text('Stato: ${_getStatus()}'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text('Descrizione :'),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200, // Altezza fissa per la descrizione
              child: SingleChildScrollView(
                child: Text(
                  widget.description,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
