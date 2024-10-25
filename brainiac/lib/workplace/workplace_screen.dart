import 'package:brainiac/workplace/workplace_addexam.dart';
import 'package:flutter/material.dart';

class WorkplaceScreen extends StatelessWidget {
  const WorkplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WORKPLACE'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WorkplaceAddexam()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
