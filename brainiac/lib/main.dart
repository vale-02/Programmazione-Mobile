import 'package:brainiac/model/exam.dart';
import 'package:brainiac/model/year.dart';
import 'package:brainiac/workplace/workplace_screen.dart';
import 'package:brainiac/years/year_selectionmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  // Inizializzazione database Hive
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(YearAdapter());
  Hive.registerAdapter(ExamAdapter());

  // Inizializzazione file .env
  await dotenv.load(fileName: ".env");

  // Inizializzazione Provider
  runApp(
    ChangeNotifierProvider(
      create: (context) => YearSelectionModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: WorkplaceScreen(),
    );
  }
}
