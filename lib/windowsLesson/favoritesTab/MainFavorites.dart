import 'package:flutter/material.dart';
import '../../database/ObjectTables.dart';
import '../../database/MainDatabase.dart';
import '../../database/Storage.dart';
import 'ComponentWord.dart';

class MainFavorite extends StatefulWidget {
  final String uidUser;
  MainFavorite({Key key, this.uidUser}) : super(key: key);

  @override
  _MainFavoriteState createState() => _MainFavoriteState();
}

class _MainFavoriteState extends State<MainFavorite> {
  MainDatabase mainDatabase = MainDatabase();
  Storage _storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Mis palabras',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              //Example component
              FutureBuilder(
                future: mainDatabase.getWordFavorites(widget.uidUser),
                initialData: List<WordFavorites>(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<WordFavorites>> snapshot) {
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    return Column(
                      children: [
                        for (WordFavorites wordFavorites in snapshot.data)
                          FutureBuilder(
                              future: _storage.getImageAndURLSound(
                                  wordFavorites.pathImage,
                                  wordFavorites.pathSound),
                              builder: (c, s) {
                                if (s.hasData) {
                                  return ComponentWord(
                                    uidUser: widget.uidUser,
                                    wordInSpanish: wordFavorites.wordSpanish,
                                    wordInChatino: wordFavorites.wordChatino,
                                    image: {
                                      'URL': s.data['imageURL'],
                                      'path': wordFavorites.pathImage
                                    },
                                    sound: {
                                      'URL': s.data['soundURL'],
                                      'path': wordFavorites.pathSound
                                    },
                                  );
                                } else {
                                  return Center(
                                      child: Column(
                                    children: [
                                      SizedBox(height: 30),
                                      CircularProgressIndicator(),
                                    ],
                                  ));
                                }
                              })
                      ],
                    );
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      alignment: Alignment.center,
                      child: Text(
                        'No hay palabras favoritas',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
