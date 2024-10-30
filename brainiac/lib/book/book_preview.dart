import 'package:brainiac/book/widget/book_view.dart';
import 'package:brainiac/model/book.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookPreview extends StatefulWidget {
  const BookPreview({super.key, required this.book});
  final Book book;

  @override
  State<BookPreview> createState() => _BookPreview();
}

class _BookPreview extends State<BookPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(100.0, 100.0, 0.0, 0.0),
                items: [
                  PopupMenuItem(
                    value: 'preview',
                    child: Row(
                      children: [
                        Text('Leggi anteprima'),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.chrome_reader_mode_outlined),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                      value: 'buy',
                      child: Row(
                        children: [
                          Text('Acquista libro'),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.attach_money_sharp),
                        ],
                      )),
                  PopupMenuItem(
                      value: 'storage',
                      child: Row(
                        children: [
                          Text('Archivia libro'),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.folder_open_outlined),
                        ],
                      )),
                ],
              ).then(
                (value) => {
                  if (value == 'preview')
                    {
                      launchUrl(
                        Uri.parse(widget.book.previewLink),
                      )
                    },
                  if (value == 'buy')
                    {
                      launchUrl(
                        Uri.parse(widget.book.buyLink),
                      )
                    },
                  if (value == 'storage')
                    {
                      BookView(
                        onDelete: () => setState(() {}),
                      ).addBook(context, widget.book),
                    },
                },
              );
            },
            icon: Icon(Icons.menu_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.book.thumbnailUrl,
              width: 150.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150.0,
                  height: 140.0,
                  color: Colors.grey,
                  child: Icon(Icons.error),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(widget.book.description != 'N/A'
                ? widget.book.description
                : 'Nessuna descrizione presente per questo libro'),
          ],
        ),
      ),
    );
  }
}
