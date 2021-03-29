import 'package:flutter/material.dart';
import 'lesson/MainLesson.dart';

class ComponentLevel extends StatefulWidget {
  final Function callbackRefresh;
  final String uidUser;
  final int typeUser;
  final int numLevel;
  final bool isAccessibleLessonOne;
  final bool isAccessibleLessonTwo;
  final bool isAccessibleLessonThree;
  final bool isFinishedLessonOne;
  final bool isFinishedLessonTwo;
  final bool isFinishedLessonThree;
  ComponentLevel(
      {Key key,
      this.numLevel,
      this.isAccessibleLessonOne,
      this.isAccessibleLessonTwo,
      this.isAccessibleLessonThree,
      this.isFinishedLessonOne,
      this.isFinishedLessonTwo,
      this.isFinishedLessonThree,
      this.uidUser,
      this.typeUser,
      this.callbackRefresh})
      : super(key: key);

  @override
  _ComponentLevelState createState() => _ComponentLevelState();
}

class _ComponentLevelState extends State<ComponentLevel> {
  Route _handleNavigationPressed(int numLesson) {
    return PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      pageBuilder: (context, animation, secondaryAnimation) => MainLesson(
        numLevel: widget.numLevel,
        numLesson: numLesson,
        uidUser: widget.uidUser,
        typeUser: widget.typeUser,
        callbackRefresh: widget.callbackRefresh,
      ),
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

  Widget _lessonComponent(int numLesson, String pathImage, bool isAccessible) =>
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 130,
            width: (MediaQuery.of(context).size.width / 2) - 23,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(pathImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 7,
                ),
                (isAccessible)
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(_handleNavigationPressed(numLesson));
                        },
                        child: Text(
                          "Iniciar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : SizedBox(
                        height: 50,
                      ),
                Text(
                  'Leccion $numLesson',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          //),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Nivel ${widget.numLevel}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                _lessonComponent(
                    1,
                    (widget.isFinishedLessonOne)
                        ? 'assets/lessonHome/huevo_normal.png'
                        : 'assets/lessonHome/huevo_gris.png',
                    widget.isAccessibleLessonOne),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _lessonComponent(
                        2,
                        (widget.isFinishedLessonTwo)
                            ? 'assets/lessonHome/huevo_amarillo.png'
                            : 'assets/lessonHome/huevo_gris.png',
                        widget.isAccessibleLessonTwo),
                    _lessonComponent(
                        3,
                        (widget.isFinishedLessonThree)
                            ? 'assets/lessonHome/huevo_rojo.png'
                            : 'assets/lessonHome/huevo_gris.png',
                        widget.isAccessibleLessonThree),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
