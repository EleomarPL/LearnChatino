import 'package:flutter/material.dart';
import '../registerUser/mainWindow.dart' as registerUser;
import '../windowsLesson/MainWindowLesson.dart' as windowLesson;

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

  Route _handleNavigationPressed() {
    return PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      pageBuilder: (context, animation, secondaryAnimation) =>
          registerUser.MainWindow(),
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

  Route _handleNavigationPressedToLessons() {
    return PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      pageBuilder: (context, animation, secondaryAnimation) =>
          windowLesson.MainWindow(),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 3,
        ),
        Expanded(
          flex: 11,
          child: Image.asset(
            'assets/header.png',
            width: double.infinity - 100,
            fit: BoxFit.cover,
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 13,
          child: Material(
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
                        onPressed: () => {
                          /*if (_formKey.currentState.validate())
                            {
                              print("entro"),
                            }*/
                          Navigator.of(context)
                              .push(_handleNavigationPressedToLessons()),
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 14,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "¿No tienes cuenta?, ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Flexible(
                child: GestureDetector(
                  child: Text(
                    "Crea uno aquí!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  onTap: () => {
                    Navigator.of(context).push(_handleNavigationPressed()),
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
