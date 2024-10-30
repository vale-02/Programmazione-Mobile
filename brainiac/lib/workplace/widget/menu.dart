import 'package:brainiac/storage/storage_screen.dart';
import 'package:brainiac/years/year_selectionmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  // Pulsante per eliminare completamente il DB con messaggio di conferma e deselezione anno
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(100.0, 100.0, 0.0, 0.0),
          items: [
            PopupMenuItem(
              value: 'storage',
              child: Row(
                children: [
                  Text('Archivio'),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.folder_open_outlined),
                ],
              ),
            ),
            PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Text('Elimina tutti i dati'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.delete_forever_rounded),
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
                  showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    useSafeArea: true,
                    builder: (context) => AlertDialog(
                      scrollable: true,
                      title: Text('Eliminare tutti i dati'),
                      content: Text(
                          'Vuoi eliminare definitivamente tutti i dati sul dispositivo?'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            final model = Provider.of<YearSelectionModel>(
                                context,
                                listen: false);
                            Hive.box('YearBox').clear();
                            Hive.box('ExamBox').clear();
                            Hive.box('VideoBox').clear();
                            Hive.box('PlaylistBox').clear();
                            Hive.box('BookBox').clear();

                            model.resetYear();
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
                  )
                }
            });
      },
      icon: Icon(Icons.menu_rounded),
    );
  }
}
