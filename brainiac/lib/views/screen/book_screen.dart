import 'package:brainiac/services/api/book_api_service.dart';
import 'package:brainiac/views/book_view.dart';
import 'package:brainiac/models/book.dart';
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
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.blue,
          fontSize: 20,
          fontFamily: 'Museo Moderno',
        ),
        title: Text('Libri'),
      ),
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
