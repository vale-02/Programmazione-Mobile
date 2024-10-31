import 'package:brainiac/homepage/homepage_screen.dart';
import 'package:brainiac/workplace/workplace_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

// Funzionalità scorrimento tra la home e la workplace
class _HomePage extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF19191E),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        physics: _currentPageIndex == 0
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        dragStartBehavior: DragStartBehavior.start,
        children: const [
          HomepageScreen(),
          WorkplaceScreen(),
        ],
      ),
    );
  }
}
