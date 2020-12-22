import 'package:flutter/material.dart';

import '../HeaderWindowLesson.dart';
import 'BaseWindowPronunciaton.dart';

class MainPronunciaton extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  MainPronunciaton({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _MainPronunciatonState createState() => _MainPronunciatonState();
}

class _MainPronunciatonState extends State<MainPronunciaton> {
  Route _handleNavigationPressed(bool isBasicVowel) {
    return PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      pageBuilder: (context, animation, secondaryAnimation) =>
          BaseWindowPronunciaton(
        numLevel: widget.numLevel,
        numLesson: widget.numLesson,
        isBasicVowel: isBasicVowel,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.ease));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _componentOption(String title, Color colorBackground) => Container(
        color: colorBackground,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 60.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return HeaderWindowLesson(
      lesson: 'Lección ${widget.numLesson}',
      titleBody: 'Pronunciación',
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: Column(
          children: [
            GestureDetector(
              child: _componentOption(
                'VOCALES BÁSICAS',
                Colors.red[600],
              ),
              onTap: () {
                Navigator.of(context).push(_handleNavigationPressed(true));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              child: _componentOption(
                'VOCALES LARGAS',
                Colors.orange[600],
              ),
              onTap: () {
                Navigator.of(context).push(_handleNavigationPressed(false));
              },
            ),
          ],
        ),
      ),
    );
  }
}
