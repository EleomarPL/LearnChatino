import 'package:flutter/material.dart';
import '../../database/MainDatabase.dart';
import '../../homeWindow/ComponentsHome.dart';

class Options {
  cases(String val, BuildContext context, int idUser, Function callback) {
    switch (val) {
      case 'Cerrar sesión':
        return closeSesion(context);
        break;
      case 'Reiniciar todo':
        return restartAll(context, idUser, callback);
        break;
    }
  }

  closeSesion(BuildContext context) {
    _previousMessague(context, '¿Esta seguro que quiere cerrar sesión?', () {
      Navigator.of(context).pushAndRemoveUntil(
          _handleNavigationPressed(ComponentsHome()), (route) => false);
    });
  }

  restartAll(BuildContext context, int idUser, Function callback) {
    _previousMessague(
        context, 'Esta opcion borrara todos sus progresos, ¿Esta seguro?',
        () async {
      MainDatabase _db = MainDatabase();
      await _db.initDB();
      await _db.deleteAllProgressUser(idUser);
      callback();
      Navigator.pop(context);
    });
  }

  Route _handleNavigationPressed(Widget nextWindow) {
    return PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      pageBuilder: (context, animation, secondaryAnimation) => nextWindow,
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

  _previousMessague(
      BuildContext context, String principalText, Function actionYes) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.black87,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    principalText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        color: Colors.blue[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        child: Text(
                          'Si',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: actionYes,
                      ),
                      RaisedButton(
                        color: Colors.blue[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        child: Text(
                          'No',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
