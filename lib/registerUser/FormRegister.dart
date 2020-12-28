import 'package:flutter/material.dart';
import '../database/MainDatabase.dart';
import '../database/ObjectTables.dart';

class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerName = TextEditingController();

  TextEditingController controllerUser = TextEditingController();

  String dropdownValue = "Modo aprendiz";
  String textDescriptionDropDown =
      "Este modo te permite ir avanzando las lecciones una por una, hasta terminar todas";

  Widget _textFormFieldBox(TextEditingController controllerBox,
      String labelTextBox, bool isFocused) {
    return TextFormField(
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

  _showMessague() => showDialog(
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
                      'Ya existe una cuenta con el mismo usuario, '
                      'utilice otro',
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
              _textFormFieldBox(controllerUser, "Usuario", false),
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
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    MainDatabase _db = MainDatabase();
                    await _db.initDB();
                    Future<int> isEmpty =
                        _db.queryUser((controllerUser.text).trim());
                    isEmpty.then((value) async {
                      if (value == null) {
                        await _db.insertUser(User(
                            (controllerName.text).trim(),
                            (controllerUser.text).trim(),
                            (dropdownValue == "Modo aprendiz" ? 0 : 1)));
                        await _db.close();
                        Navigator.pop(context);
                      } else {
                        _showMessague();
                        await _db.close();
                      }
                    });
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
}
