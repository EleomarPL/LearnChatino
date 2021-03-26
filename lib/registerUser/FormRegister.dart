import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  String dropdownValue = "Modo aprendiz";
  String textDescriptionDropDown =
      "Este modo te permite ir avanzando las lecciones una por una, hasta terminar todas";

  Widget _textFormFieldBox(
      TextEditingController controllerBox, String labelTextBox, bool isFocused,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controllerBox,
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
        labelText: labelTextBox,
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

  _showMessage(msg) => showDialog(
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
                      msg,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
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
                            'Ok',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => {
                            Navigator.pop(context),
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _textFormFieldBox(controllerName, "Nombre", false),
              _textFormFieldBox(
                controllerEmail,
                "Email",
                false,
                keyboardType: TextInputType.emailAddress,
              ),
              _textFormFieldBox(
                controllerPassword,
                "Contraseña",
                false,
                obscureText: true,
              ),
              SizedBox(
                height: 40,
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 30,
                ),
                isExpanded: true,
                dropdownColor: Colors.transparent,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    (newValue != dropdownValue)
                        ? textDescriptionDropDown = ((newValue ==
                                "Modo aprendiz")
                            ? "Este modo te permite ir avanzando las lecciones una por una, hasta terminar todas"
                            : "Este modo te desbloquea todas las lecciones, te permite acceder a todas las lecciones")
                        // ignore: unnecessary_statements
                        : null;
                    dropdownValue = newValue;
                  });
                },
                items: <String>[
                  'Modo aprendiz',
                  'Modo libre',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                textDescriptionDropDown,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.blue[900],
                child: Text(
                  'Aceptar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _registerAccount();
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Chatino Variante Oriental Bajo",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registerAccount() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: controllerEmail.text.trim(),
        password: controllerPassword.text.trim(),
      );
      await userCredential.user
          .updateProfile(displayName: controllerName.text.trim());
      await _db.collection('users').add({
        "uid": userCredential.user.uid,
        "type": dropdownValue == "Modo aprendiz" ? 0 : 1
      });
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
        _showMessage(
            'La contraseña es debil. Escriba una mezclando letras y numeros.');
      else if (e.code == 'email-already-in-use')
        _showMessage(
            'Ya existe una cuenta registrada con este email. Escriba otro emial');
      else if (e.code == 'invalid-email')
        _showMessage(
            'La dirección email no tiene un formato valido. Debe de contener "@"');
      else if (e.code == 'unknown')
        _showMessage(
            'No se pudo establecer conexión con el servidor. Compruebe su conexión a Internet.');
      else
        _showMessage('Mensaje: ${e.message}. Codigo: ${e.code}');
    } catch (e) {
      _showMessage('Error desconocido');
      print(e);
    }
  }
}
