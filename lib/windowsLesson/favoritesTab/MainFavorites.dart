import 'package:flutter/material.dart';
import 'ComponentWord.dart';

class MainFavorite extends StatefulWidget {
  final int idUser;
  MainFavorite({Key key, this.idUser}) : super(key: key);

  @override
  _MainFavoriteState createState() => _MainFavoriteState();
}

class _MainFavoriteState extends State<MainFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: RaisedButton(
        color: Colors.blue[900],
        child: Text(
          'AÑADIR PALABRA NUEVA',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        onPressed: () => {},
      ),
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
              ComponentWord(
                wordInSpanish: "Bienvenido",
                wordInChatino: "Ninansca",
                pathImage: "assets/background.png",
              ),
            ],
          )
        ],
      ),
    );
  }
}
