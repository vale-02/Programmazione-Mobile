import 'package:auto_size_text/auto_size_text.dart';
import 'package:brainiac/book/book_preview.dart';
import 'package:brainiac/storage/function/add_book.dart';
import 'package:brainiac/storage/function/delete_book.dart';
import 'package:brainiac/model/book.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BookView {
  BookView({required this.onDelete});
  void Function() onDelete;

  //Funzione visualizzazione modello Book con gestione tocco e icona per l'archivio
  Widget buildBook(BuildContext context, Book book, {bool delete = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookPreview(
              book: book,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image.network(
              book.thumbnailUrl,
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
              width: 10.0,
            ),
            Expanded(
              child: AutoSizeText(
                book.title,
                maxLines: 6,
                minFontSize: 10,
                stepGranularity: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ),
            icon(delete, context, book),
          ],
        ),
      ),
    );
  }

  Widget icon(bool delete, BuildContext context, Book book) {
    if (!delete) {
      return IconButton(
        onPressed: () {
          AddBook().addBook(context, book);
        },
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedFolderAdd,
          color: Color(0xFFFC8D0A),
        ),
      );
    }
    return IconButton(
      onPressed: () {
        DeleteBook(onDelete: onDelete).deleteBook(context, book);
      },
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedFolderRemove,
        color: Color(0xFFFC8D0A),
      ),
    );
  }
}
