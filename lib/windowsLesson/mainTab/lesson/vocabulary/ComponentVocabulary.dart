import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import '../../../../database/MainDatabase.dart';
import '../../../../database/ObjectTables.dart';

class ComponentVocabulary extends StatefulWidget {
  final String uidUser;
  final String wordInSpanish;
  final String wordInChatino;
  final Map<String, String> image;
  final Map<String, String> sound;

  ComponentVocabulary(
      {Key key,
      this.wordInSpanish,
      this.image,
      this.sound,
      this.wordInChatino,
      this.uidUser})
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
  _methodInitComponent() async {
    MainDatabase _database = MainDatabase();
    bool band = await _database.existThisWordInFavorite(
        widget.uidUser, widget.wordInSpanish);
    setState(() {
      colorFavorite = (band) ? Colors.red[900] : Colors.white;
    });
  }

  @override
  void initState() {
    _methodInitComponent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 210,
                width: (MediaQuery.of(context).size.width) - 23,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.image['URL']),
                    fit: BoxFit.contain,
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
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textWords(widget.wordInSpanish, 22.0, FontWeight.bold),
                      _textWords(widget.wordInChatino, 21.0, FontWeight.normal),
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
                        onTap: () async {
                          MainDatabase _db = MainDatabase();
                          (colorFavorite == Colors.white)
                              ? _db.insertWordFavorite(WordFavorites(
                                  widget.uidUser,
                                  widget.wordInSpanish,
                                  widget.wordInChatino,
                                  widget.image['path'],
                                  widget.sound['path']))
                              : _db.deleteWord(
                                  widget.uidUser, widget.wordInSpanish);
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
          onTap: () {
            AssetsAudioPlayer.newPlayer().open(
              Audio.network(widget.sound['URL']),
              autoStart: true,
              showNotification: true,
            );
          },
        ),
        SizedBox(
          height: 14.0,
        ),
      ],
    );
  }
}
