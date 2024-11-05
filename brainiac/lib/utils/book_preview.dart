import 'package:brainiac/models/book.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              _showPopUpMenu(context);
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                child: Image.network(
                  widget.book.thumbnailUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140.0,
                      color: Colors.grey,
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.book.title,
                style: TextStyle(
                  color: Color(0xFFFE2C8D),
                  fontSize: 15,
                  fontFamily: 'Museo Moderno',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.book.description != 'N/A'
                    ? widget.book.description
                    : 'Nessuna descrizione presente per questo libro',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Museo Moderno',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
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
          value: 'preview',
          child: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedView,
                color: Colors.blue,
                size: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Anteprima',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'buy',
          child: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedTrolley02,
                color: Color(0xFFFE2C8D),
                size: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Acquista libro',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Museo Moderno',
                ),
              ),
            ],
          ),
        ),
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
          }
      },
    );
  }
}
