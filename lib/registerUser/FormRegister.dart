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
            : ((value.length > 29) ? "Maximo 25 caracteres" : null);
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
                    await _db.insertUser(User(
                        controllerName.text,
                        controllerUser.text,
                        (dropdownValue == "Modo aprendiz" ? 0 : 1)));
                    Navigator.pop(context);
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
