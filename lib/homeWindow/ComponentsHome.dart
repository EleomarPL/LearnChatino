import 'package:flutter/material.dart';
import '../registerUser/MainWindow.dart' as registerUser;
import '../windowsLesson/MainWindowLesson.dart' as windowLesson;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  bool isProcessingQuery = false;

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

  _messageError(String principalText) {
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
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
                        _buildField(
                          controllerEmail,
                          "Email",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        _buildField(
                          controllerPassword,
                          "Contraseña",
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue[900],
                              padding: EdgeInsets.only(top: 10, bottom: 10)),
                          child: isProcessingQuery
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(width: 15),
                                    Text(
                                      'INICIAR SESIÓN',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'INICIAR SESIÓN',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                          onPressed: () {
                            if (!isProcessingQuery &&
                                _formKey.currentState.validate()) {
                              setState(() {
                                isProcessingQuery = true;
                              });
                              _signInWithEmailAndPassword();
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.all(0.0),
                  ),
                  child: Text(
                    "Crea uno aquí!",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  onPressed: isProcessingQuery
                      ? null
                      : () => {
                            Navigator.of(context).push(_handleNavigationPressed(
                                registerUser.MainWindow())),
                          },
                  onLongPress: null,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _buildField(TextEditingController controller, String label,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      validator: (String value) {
        return (value.trim().isEmpty)
            ? 'Rellena el campo'
            : ((value.length > 29) ? "Maximo 29 caracteres" : null);
      },
      style: TextStyle(
        fontSize: 23,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
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
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: controllerEmail.text.trim(),
        password: controllerPassword.text.trim(),
      );
      final String uid = userCredential.user.uid;
      print(uid);
      final infoUser =
          await _db.collection('users').where('uid', isEqualTo: uid).get();
      Navigator.of(context).pushAndRemoveUntil(
          _handleNavigationPressed(windowLesson.MainWindow(
            uidUser: userCredential.user.uid,
            typeUser: infoUser.docs.first.data()['type'],
          )),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      print('Datos incorrectos...');
      if (e.code == 'invalid-email')
        _messageError(
            'La dirección email no tiene un formato valido. Debe de contener "@"');
      else if (e.code == 'user-not-found')
        _messageError('Vaya!, no existe esta cuenta, lo puede crear '
            'con el boton "Crea uno aquí!"');
      else if (e.code == 'wrong-password')
        _messageError('La contraseña es incorrecta');
      else if (e.code == 'too-many-requests')
        _messageError('Demasiados intentos fallidos. Intentar mas tarde');
      else if (e.code == 'unknown')
        _messageError(
            'No se pudo establecer conexión con el servidor. Compruebe su conexión a Internet.');
      else
        _messageError('Mensaje: ${e.message}. Codigo: ${e.code}');
    } catch (e) {
      _messageError('Error desconocido');
      print(e);
    } finally {
      setState(() {
        isProcessingQuery = false;
      });
    }
  }
}
