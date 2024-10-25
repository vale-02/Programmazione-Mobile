import 'package:brainiac/model/exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class WorkplaceEditexam extends StatefulWidget {
  const WorkplaceEditexam(
      {super.key,
      required this.id,
      required this.name,
      required this.cfu,
      required this.status});
  final int id;
  final String name;
  final int cfu;
  final bool status;

  @override
  State<WorkplaceEditexam> createState() => _WorkplaceEditexam();
}

class _WorkplaceEditexam extends State<WorkplaceEditexam> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cfuController = TextEditingController();
  late bool _statusController;

  @override
  void initState() {
    _nameController.text = widget.name;
    _cfuController.text = widget.cfu.toString();
    _statusController = widget.status;

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cfuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifica esame'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome esame',
                  hintText: widget.name,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _cfuController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                    labelText: 'CFU', hintText: widget.cfu.toString()),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton<bool>(
                value: _statusController,
                onChanged: (bool? newValue) {
                  setState(() {
                    _statusController = newValue!;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text('Superato'),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text('In corso'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final value = Exam(
                    id: widget.id,
                    name: _nameController.text,
                    cfu: int.parse(_cfuController.text),
                    status: _statusController,
                  );
                  Hive.box('ExamBox').putAt(widget.id, value);
                  Navigator.pop(context);
                },
                child: Text('Modifica esame'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
