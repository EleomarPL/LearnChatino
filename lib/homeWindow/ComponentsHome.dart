import 'package:flutter/material.dart';
import '../registerUser/MainWindow.dart' as registerUser;
import '../windowsLesson/MainWindowLesson.dart' as windowLesson;
import '../database/MainDatabase.dart';

class ComponentsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background(),
        bodyMainWindow(),
      ],
    );
  }
}

Widget _background() => Opacity(
      opacity: 0.3,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.fill,
          ),
          //shape: BoxShape.circle,
        ),
      ),
    );

// ignore: camel_case_types
class bodyMainWindow extends StatefulWidget {
  @override
  _bodyMainWindowState createState() => _bodyMainWindowState();
}

// ignore: camel_case_types
class _bodyMainWindowState extends State<bodyMainWindow> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerUser = TextEditingController();

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

  _messagueUserNotExist(String principalText) {
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Image.asset(
              'assets/header.png',
              width: double.infinity - 100,
              fit: BoxFit.cover,
              height: 200.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            Material(
              color: Colors.transparent,
              child: Form(
                key: _formKey,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: controllerUser,
                          validator: (String value) {
                            return (value.trim().isEmpty)
                                ? 'Rellena el campo'
                                : ((value.length > 29)
                                    ? "Maximo 29 caracteres"
                                    : null);
                          },
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: "Usuario",
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Colors.blue[900],
                          child: Text(
                            'INICIAR SESIÓN',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              MainDatabase _db = MainDatabase();
                              await _db.initDB();
                              Future<Map<String, dynamic>> resultQueryUser =
                                  _db.listInformationUser(
                                      (controllerUser.text).trim());
                              resultQueryUser.then((key) async {
                                if (key != null) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      _handleNavigationPressed(
                                          windowLesson.MainWindow(
                                        idUser: key['idUser'],
                                        typeUser: key['typeUser'],
                                      )),
                                      (route) => false);
                                } else {
                                  _messagueUserNotExist(
                                      'Vaya!, no existe esta cuenta, lo puede crear '
                                      'con el boton "Crea uno aquí!"');
                                }
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "¿No tienes cuenta?, ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0.0,
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    "Crea uno aquí!",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  onPressed: () => {
                    Navigator.of(context).push(
                        _handleNavigationPressed(registerUser.MainWindow())),
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
