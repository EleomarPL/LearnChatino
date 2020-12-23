import 'package:flutter/material.dart';

Widget _textComponentPonunciaton(
        String text, double sizeText, FontWeight weightText) =>
    Text(
      text,
      style: TextStyle(
        fontSize: sizeText,
        fontWeight: weightText,
      ),
    );

class ComponentPronunciaton extends StatelessWidget {
  final String pathImage;
  final String wordInSpanish;
  final String wordInChatino;
  final String pathSound;
  const ComponentPronunciaton(
      {Key key,
      this.pathImage,
      this.wordInSpanish,
      this.wordInChatino,
      this.pathSound})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          child: Image.asset(
            pathImage,
            width: MediaQuery.of(context).size.width - 100,
            height: 180.0,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        _textComponentPonunciaton(wordInSpanish, 40, FontWeight.w600),
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textComponentPonunciaton(wordInChatino, 35, FontWeight.normal),
              Icon(
                Icons.volume_up,
                color: Colors.red,
                size: 50,
              ),
            ],
          ),
          onTap: () {
            print('play sound');
          },
        ),
      ],
    );
  }
}
