import 'package:brainiac/model/year.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class YearsScreen extends StatefulWidget {
  YearsScreen({super.key, required this.onYearSelected});
  Function(int) onYearSelected;

  @override
  State<YearsScreen> createState() => _YearsScreen();
}

class _YearsScreen extends State<YearsScreen> {
  final hiveBox = Hive.box('YearBox');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: Hive.box('YearBox').listenable(),
            builder: (context, Box box, child) {
              return IconButton(
                onPressed: Hive.box('YearBox').length < 5
                    ? () {
                        final value = Year(year: _getYear(), exams: []);
                        Hive.box('YearBox').add(value);
                      }
                    : () {},
                icon: Icon(Icons.add),
              );
            }),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ValueListenableBuilder(
              valueListenable: hiveBox.listenable(),
              builder: (context, Box box, child) {
                List<Year> years = [];

                for (int i = 0; i < box.length; i++) {
                  years.add(box.getAt(i) as Year);
                }

                years.sort((a, b) => a.year.compareTo(b.year));

                List<Widget> yearButtons = years.map((year) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          useSafeArea: true,
                          builder: (context) => AlertDialog(
                            scrollable: true,
                            title: Text('Elimina anno ${year.year}'),
                            content: Text(
                                'Vuoi eliminare definitivamente questo anno?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  int index = -1;
                                  for (int i = 0; i < hiveBox.length; i++) {
                                    Year storedYear = hiveBox.getAt(i) as Year;
                                    if (storedYear.year == year.year) {
                                      index = i;
                                      break;
                                    }
                                  }
                                  if (index != -1) {
                                    hiveBox.deleteAt(index);
                                  }
                                  widget.onYearSelected(-1);
                                  Navigator.pop(context);
                                },
                                child: Text('Elimina'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Annulla'),
                              ),
                            ],
                          ),
                        );
                      },
                      onPressed: () {
                        widget.onYearSelected(year.year);
                      },
                      child: Text('Anno ${year.year}'),
                    ),
                  );
                }).toList();

                return Row(
                  children: yearButtons,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  int _getYear() {
    final hiveBox = Hive.box('YearBox');
    List<int> existingYears = [];

    for (int i = 0; i < hiveBox.length; i++) {
      final year = hiveBox.getAt(i) as Year;
      existingYears.add(year.year);
    }

    int newYear;
    for (newYear = 1; newYear < 5; newYear++) {
      if (!existingYears.contains(newYear)) {
        break;
      }
    }
    return newYear;
  }
}
