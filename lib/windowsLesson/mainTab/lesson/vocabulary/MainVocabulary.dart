import 'package:flutter/material.dart';
import '../../../../contentData/ContentData.dart';
import '../HeaderWindowLesson.dart';
import 'ComponentVocabulary.dart';

class MainVocabulary extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  MainVocabulary({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _MainVocabularyState createState() => _MainVocabularyState();
}

class _MainVocabularyState extends State<MainVocabulary> {
  ContentData contentData = ContentData();
  @override
  Widget build(BuildContext context) {
    return HeaderWindowLesson(
      lesson: 'Lección ${widget.numLesson}',
      titleBody: 'Vocabulario',
      body: ListView(
        children: [
          Column(
            children: [
              FutureBuilder(
                  future: contentData.getVocabulary(
                      widget.numLevel, widget.numLesson),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(snapshot.data['word-1']['pathBackground']);
                      return Column(
                        children: [
                          for (int i = 0; i < (snapshot.data).length; i++)
                            ComponentVocabulary(
                              wordInSpanish: snapshot.data['word-${i + 1}']
                                      ['wordInSpanish']
                                  .toString(),
                              pathImage: snapshot.data['word-${i + 1}']
                                      ['pathBackground']
                                  .toString(),
                            )
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
