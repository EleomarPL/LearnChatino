import 'package:flutter/material.dart';
import '../../../../database/MainDatabase.dart';

class ComponentExercise extends StatefulWidget {
  final String incorrectWord1;
  final String correctWord1;
  final String incorrectWord2;
  final String correctWord2;
  final int numLevel;
  final int numLesson;
  final int idUser;
  final int typeUser;
  final int numExercise;
  ComponentExercise(
      {Key key,
      this.incorrectWord1,
      this.correctWord1,
      this.incorrectWord2,
      this.correctWord2,
      this.numLevel,
      this.numLesson,
      this.idUser,
      this.typeUser,
      this.numExercise})
      : super(key: key);

  @override
  _ComponentExerciseState createState() => _ComponentExerciseState();
}

Widget _textComponentExercise(
        String text, double sizeText, FontWeight weightText) =>
    Text(
      text,
      style: TextStyle(
        fontSize: sizeText,
        fontWeight: weightText,
      ),
    );
Widget _imageResultExercise(String pathImage) => Container(
      child: Image.asset(
        pathImage,
        width: 50,
        height: 50.0,
        fit: BoxFit.cover,
      ),
    );
Widget _textFormFieldBox(TextEditingController controllerBox) {
  return Container(
    color: Colors.blue[400],
    child: TextFormField(
      controller: controllerBox,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        focusColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      cursorColor: Colors.white,
      textAlign: TextAlign.center,
    ),
  );
}

Widget _textFormField(String incorrectWord, double sizeText,
        TextEditingController controller) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _textComponentExercise(incorrectWord, sizeText, FontWeight.w700),
        SizedBox(width: 10.0),
        Container(
          width: 200,
          child: _textFormFieldBox(controller),
        ),
      ],
    );

class _ComponentExerciseState extends State<ComponentExercise> {
  bool isVisible = false;
  bool resultExercise = true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerFirstWord = TextEditingController();
  TextEditingController controllerSecondWord = TextEditingController();

  void updateElement(bool newValue) {
    setState(() {
      isVisible = true;
      resultExercise = newValue;
    });
  }

  _methodInitResults() async {
    MainDatabase _db = MainDatabase();
    await _db.initDB();
    bool band = await _db.existThisExercise(
        int.tryParse(
            '${widget.idUser}${widget.numLevel}${widget.numLesson}${widget.numExercise}'),
        widget.idUser);
    if (band) {
      setState(() {
        updateElement(true);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.typeUser == 0) {
      _methodInitResults();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30.0,
        ),
        _textComponentExercise('Ordena las palabras', 30, FontWeight.w700),
        SizedBox(
          height: 10.0,
        ),
        Form(
          key: _formKey,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textFormField(widget.incorrectWord1, 22, controllerFirstWord),
                SizedBox(
                  height: 10.0,
                ),
                _textFormField(widget.incorrectWord2, 22, controllerSecondWord),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                    ),
                    child: Text(
                      'CALIFICAR',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if ((controllerFirstWord.text.trim() ==
                              widget.correctWord1 &&
                          controllerSecondWord.text.trim() ==
                              widget.correctWord2)) {
                        if (widget.typeUser == 0) {
                          MainDatabase _db = MainDatabase();
                          await _db.initDB();
                          await _db.insertExercisePassed(
                              widget.idUser,
                              widget.numLevel,
                              widget.numLesson,
                              widget.numExercise);
                        }
                        updateElement(true);
                      } else {
                        updateElement(false);
                      }
                    },
                  ),
                ),
                (!isVisible)
                    ? SizedBox(
                        height: 10,
                      )
                    : ((resultExercise)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _imageResultExercise(
                                  "assets/lessonHome/exercise/correcto.png"),
                              SizedBox(
                                width: 10.0,
                              ),
                              _textComponentExercise(
                                  "Muy bien", 30, FontWeight.bold)
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _imageResultExercise(
                                  "assets/lessonHome/exercise/incorrecto.png"),
                              SizedBox(
                                width: 10.0,
                              ),
                              _textComponentExercise(
                                  "Intentar de nuevo", 20, FontWeight.bold)
                            ],
                          )),
              ],
            ),
          ),
        ),
        //),
      ],
    );
  }
}
