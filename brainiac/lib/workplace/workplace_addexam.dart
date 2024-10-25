import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WorkplaceAddexam extends StatefulWidget {
  const WorkplaceAddexam({super.key});

  @override
  State<WorkplaceAddexam> createState() => _WorkplaceAddexam();
}

class _WorkplaceAddexam extends State<WorkplaceAddexam> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserisci i dati dell\'esame'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome esame'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Aggiungi esame'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
