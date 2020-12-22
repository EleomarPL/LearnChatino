import 'package:flutter/material.dart';

class ComponentWord extends StatefulWidget {
  final String wordInSpanish;
  final String wordInChatino;
  final String pathImage;
  ComponentWord(
      {Key key, this.wordInSpanish, this.wordInChatino, this.pathImage})
      : super(key: key);

  @override
  _ComponentWordState createState() => _ComponentWordState();
}

Widget _textWords(String text, double sizeWord, FontWeight weightText) => Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: sizeWord,
        fontWeight: weightText,
      ),
    );

class _ComponentWordState extends State<ComponentWord> {
  Color colorFavorite = Colors.red[900];
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
                    Row(
                      children: [
                        _textWords(
                            widget.wordInChatino, 21.0, FontWeight.normal),
                        Icon(
                          Icons.volume_up,
                          color: Colors.white,
                          size: 30,
                        )
                      ],
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
                              "Quitar de favoritos", 19.0, FontWeight.normal),
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
