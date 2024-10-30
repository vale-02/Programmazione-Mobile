import 'package:brainiac/book/api_service.dart';
import 'package:brainiac/view/book_view.dart';
import 'package:brainiac/model/book.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.searchName});
  final String searchName;

  @override
  State<BookScreen> createState() => _BookScreen();
}

// Schermata visualizzazione elenco libri presi dalla chiamata API
class _BookScreen extends State<BookScreen> {
  List<Book> _result = [];

  @override
  void initState() {
    _initBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _result.isNotEmpty
          ? ListView.builder(
              itemCount: _result.length,
              itemBuilder: (context, index) {
                return BookView(onDelete: () => setState(() {}))
                    .buildBook(context, _result[index]);
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void _initBook() async {
    List<Book> book =
        await ApiService.instance.fetchBookFromSearch(widget.searchName);
    setState(() {
      _result = book;
    });
  }
}
