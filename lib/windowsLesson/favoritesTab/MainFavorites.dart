import 'package:flutter/material.dart';
import '../../database/ObjectTables.dart';
import '../../database/MainDatabase.dart';
import 'ComponentWord.dart';

class MainFavorite extends StatefulWidget {
  final int idUser;
  MainFavorite({Key key, this.idUser}) : super(key: key);

  @override
  _MainFavoriteState createState() => _MainFavoriteState();
}

_validateData(BuildContext context, MainDatabase mainDatabase, int idUser) {
  return FutureBuilder(
    future: mainDatabase.getWordFavorites(idUser),
    initialData: List<WordFavorites>(),
    builder:
        (BuildContext context, AsyncSnapshot<List<WordFavorites>> snapshot) {
      if (snapshot.hasData && snapshot.data.length != 0) {
        return Column(
          children: [
            for (WordFavorites wordFavorites in snapshot.data)
              ComponentWord(
                idUser: idUser,
                wordInSpanish: wordFavorites.wordSpanish,
                wordInChatino: wordFavorites.wordChatino,
                pathImage: wordFavorites.pathImage,
                pathSound: wordFavorites.pathSound,
              ),
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
  );
}

class _MainFavoriteState extends State<MainFavorite> {
  MainDatabase mainDatabase = MainDatabase();
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
                future: mainDatabase.initDB(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _validateData(context, mainDatabase, widget.idUser);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
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
