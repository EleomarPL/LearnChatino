import 'package:flutter/material.dart';

class ComponentVocabulary extends StatefulWidget {
  final String wordInSpanish;
  final String pathImage;
  ComponentVocabulary({Key key, this.wordInSpanish, this.pathImage})
      : super(key: key);

  @override
  _ComponentVocabularyState createState() => _ComponentVocabularyState();
}

Widget _textWords(String text, double sizeWord, FontWeight weightText) => Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: sizeWord,
        fontWeight: weightText,
      ),
    );

class _ComponentVocabularyState extends State<ComponentVocabulary> {
  Color colorFavorite = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 210,
              width: (MediaQuery.of(context).size.width) - 23,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.pathImage),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black54,
                      Colors.black12,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textWords(widget.wordInSpanish, 22.0, FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),
                    Icon(
                      Icons.volume_up,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: colorFavorite,
                            size: 25,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          _textWords(
                              "Añadir a favoritos", 19.0, FontWeight.normal),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          colorFavorite = (colorFavorite == Colors.white)
                              ? Colors.red[900]
                              : Colors.white;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            //),
          ],
        ),
        SizedBox(
          height: 14.0,
        ),
      ],
    );
  }
}
