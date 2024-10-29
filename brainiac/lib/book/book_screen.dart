import 'package:brainiac/book/api_service.dart';
import 'package:brainiac/model/book.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.searchName});
  final String searchName;

  @override
  State<BookScreen> createState() => _BookScreen();
}

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
                return _buildBook(_result[index]);
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

  Widget _buildBook(Book book) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      padding: EdgeInsets.all(5.0),
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
                color: Colors.grey, // Colore di sfondo per l'errore
                child: Icon(Icons.error), // Icona di errore
              );
            },
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              book.title,
            ),
          ),
        ],
      ),
    );
  }
}
