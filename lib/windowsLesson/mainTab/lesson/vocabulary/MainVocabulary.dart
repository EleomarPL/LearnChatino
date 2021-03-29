import 'package:flutter/material.dart';
import '../../../../contentData/ContentData.dart';
import '../../../../database/Storage.dart';
import '../HeaderWindowLesson.dart';
import 'ComponentVocabulary.dart';

class MainVocabulary extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  final String uidUser;
  MainVocabulary({Key key, this.numLevel, this.numLesson, this.uidUser})
      : super(key: key);

  @override
  _MainVocabularyState createState() => _MainVocabularyState();
}

class _MainVocabularyState extends State<MainVocabulary> {
  ContentData contentData = ContentData();
  Storage _storage = Storage();
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
                  builder: (context,
                      AsyncSnapshot<List<Map<String, String>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                          children: snapshot.data
                              .map((word) => FutureBuilder(
                                  future: _storage.getImageAndURLSound(
                                      word['pathBackground'],
                                      word['pathSound']),
                                  builder: (c,
                                      AsyncSnapshot<Map<String, String>> s) {
                                    if (s.hasData) {
                                      return ComponentVocabulary(
                                        uidUser: widget.uidUser,
                                        wordInSpanish: word['wordInSpanish'],
                                        wordInChatino: word['wordInChatino'],
                                        image: {
                                          'URL': s.data['imageURL'],
                                          'path': word['pathBackground']
                                        },
                                        sound: {
                                          'URL': s.data['soundURL'],
                                          'path': word['pathSound']
                                        },
                                      );
                                    } else {
                                      return Center(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 30),
                                            CircularProgressIndicator(),
                                          ],
                                        ),
                                      );
                                    }
                                  }))
                              .toList());
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
