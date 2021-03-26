import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'favoritesTab/MainFavorites.dart';
import 'informationTab/MainInformation.dart';
import 'mainTab/MainMain.dart';
import './loggedUserOptions/Options.dart';

class MainWindow extends StatefulWidget {
  final String uidUser;
  final int typeUser;
  MainWindow({Key key, this.uidUser, this.typeUser}) : super(key: key);

  @override
  _mainWindowState createState() => _mainWindowState();
}

Widget _textTabBar(String text) => Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );

// ignore: camel_case_types
class _mainWindowState extends State<MainWindow> {
  refreshPage() {
    setState(() {
      this.reassemble();
    });
  }

  Options options = Options();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.yellow,
            tabs: [
              Tab(child: _textTabBar("Principal")),
              Tab(child: _textTabBar("Favoritos")),
              Tab(child: _textTabBar("Informacion")),
            ],
          ),
          title: Text('Aprendamos Chatino'),
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            DropdownButton(
              onChanged: (String val) {
                options.cases(val, context, widget.uidUser, refreshPage);
              },
              dropdownColor: Colors.black,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              icon: Icon(
                Icons.more_vert,
                size: 30,
                color: Colors.white,
              ),
              underline: Container(
                color: Colors.transparent,
              ),
              items: <String>[
                'Cerrar sesión',
                'Reiniciar todo',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            MainMain(
              uidUser: widget.uidUser,
              typeUser: widget.typeUser,
            ),
            MainFavorite(
              uidUser: widget.uidUser,
            ),
            MainInformation(),
          ],
        ),
      ),
    );
  }
}
