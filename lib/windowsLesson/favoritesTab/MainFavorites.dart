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
                builder:
                    (context, AsyncSnapshot<List<WordFavorites>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data.length != 0) {
                      return Column(
                          children: snapshot.data
                              .map((word) => FutureBuilder(
                                    future: _storage.getImageAndURLSound(
                                        word.pathImage, word.pathSound),
                                    builder: (c,
                                        AsyncSnapshot<Map<String, String>> s) {
                                      if (s.hasData) {
                                        return ComponentWord(
                                          uidUser: widget.uidUser,
                                          wordInSpanish: word.wordSpanish,
                                          wordInChatino: word.wordChatino,
                                          image: {
                                            'URL': s.data['imageURL'],
                                            'path': word.pathImage
                                          },
                                          sound: {
                                            'URL': s.data['soundURL'],
                                            'path': word.pathSound
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
                                    },
                                  ))
                              .toList());
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
                  } else {
                    return Center(child: CircularProgressIndicator());
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
