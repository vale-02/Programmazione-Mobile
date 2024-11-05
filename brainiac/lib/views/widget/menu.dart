import 'package:brainiac/views/screen/storage_screen.dart';
import 'package:brainiac/provider/year_selectionmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  // Pulsante per eliminare completamente il DB con messaggio di conferma e deselezione anno
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _showPopUpMenu(context);
        },
        icon: Icon(
          Icons.menu_rounded,
          color: Colors.white,
          size: 30,
        ));
  }

  void _showPopUpMenu(BuildContext context) {
    showMenu(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      position: RelativeRect.fromLTRB(100.0, 70.0, 0.0, 0.0),
      items: [
        PopupMenuItem(
          value: 'storage',
          child: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedFolder01,
                color: Color(0xFFFC8D0A),
                size: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Archivio',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedDelete02,
                  color: Color.fromARGB(255, 235, 16, 16),
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Elimina dati',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Museo Moderno',
                  ),
                ),
              ],
            )),
      ],
    ).then((value) => {
          if (value == 'storage')
            {
              Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder: (_) => StorageScreen(),
                ),
              ),
            }
          else if (value == 'delete')
            {
              // ignore: use_build_context_synchronously
              _showDeleteMessageDB(context),
            }
        });
  }

  void _showDeleteMessageDB(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        title: Text(
          'Elimina dati',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 224, 193, 255),
          fontFamily: 'Museo Moderno',
        ),
        content: Text(
          'Vuoi eliminare definitivamente tutti i dati sul dispositivo?',
          textAlign: TextAlign.center,
        ),
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Museo Moderno',
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  final model =
                      Provider.of<YearSelectionModel>(context, listen: false);
                  Hive.box('YearBox').clear();
                  Hive.box('ExamBox').clear();
                  Hive.box('VideoBox').clear();
                  Hive.box('PlaylistBox').clear();
                  Hive.box('BookBox').clear();

                  model.resetYear();
                  Navigator.pop(context);
                },
                child: Text(
                  'Elimina',
                  style: TextStyle(
                    color: Color.fromARGB(255, 235, 16, 16),
                    fontFamily: 'Museo Moderno',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Annulla',
                  style: TextStyle(
                    color: Color.fromARGB(255, 224, 193, 255),
                    fontFamily: 'Museo Moderno',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
