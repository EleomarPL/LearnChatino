import 'package:flutter/material.dart';
import 'conversation/MainConversation.dart';
import 'exercise/MainExercise.dart';
import 'pronunciaton/MainPronunciaton.dart';
import 'vocabulary/MainVocabulary.dart';

class MainLesson extends StatelessWidget {
  final int numLevel;
  final int numLesson;
  const MainLesson({Key key, this.numLevel, this.numLesson}) : super(key: key);
  Route _handleNavigationPressed(Widget classToGo) {
    return PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      pageBuilder: (context, animation, secondaryAnimation) => classToGo,
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

  Widget _textLesson(String text, double sizeText, FontWeight weightText) =>
      Text(
        text,
        style: TextStyle(
          fontSize: sizeText,
          fontWeight: weightText,
        ),
      );
  Widget _optionLesson(String textDescription, Color colorBackground,
          BuildContext context) =>
      Container(
        width: MediaQuery.of(context).size.width / 2 - 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: _textLesson(textDescription[0], 90, FontWeight.w800),
              ),
              SizedBox(
                height: 5.0,
              ),
              _textLesson(textDescription, 23, FontWeight.w900),
            ],
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aprendamos Chatino'),
        bottom: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text(
            'Leccion $numLesson',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          centerTitle: true,
        ),
      ),
      bottomNavigationBar: RaisedButton(
        color: Colors.blue[900],
        child: Text(
          'SIGUIENTE LECCIÓN',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        onPressed: () => {},
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: _optionLesson('Vocabulario', Colors.green, context),
                onTap: () {
                  Navigator.of(context)
                      .push(_handleNavigationPressed(MainVocabulary(
                    numLevel: numLevel,
                    numLesson: numLesson,
                  )));
                },
              ),
              GestureDetector(
                child: _optionLesson('Pronunciación', Colors.green, context),
                onTap: () {
                  Navigator.of(context)
                      .push(_handleNavigationPressed(MainPronunciaton(
                    numLevel: numLevel,
                    numLesson: numLesson,
                  )));
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: _optionLesson('Conversación', Colors.green, context),
                onTap: () {
                  Navigator.of(context)
                      .push(_handleNavigationPressed(MainConversation(
                    numLevel: numLevel,
                    numLesson: numLesson,
                  )));
                },
              ),
              GestureDetector(
                child: _optionLesson('Ejercicios', Colors.blue[300], context),
                onTap: () {
                  Navigator.of(context)
                      .push(_handleNavigationPressed(MainExercise(
                    numLevel: numLevel,
                    numLesson: numLesson,
                  )));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
