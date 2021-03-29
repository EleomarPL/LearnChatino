import 'package:flutter/material.dart';
import '../HeaderWindowLesson.dart';
import 'ComponentConversation.dart';
import '../../../../contentData/ContentData.dart';
import '../../../../database/Storage.dart';

class MainConversation extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  MainConversation({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _MainConversationState createState() => _MainConversationState();
}

class _MainConversationState extends State<MainConversation> {
  ContentData _contentData = ContentData();
  Storage _storage = Storage();

  @override
  Widget build(BuildContext context) {
    return HeaderWindowLesson(
        lesson: 'Lección ${widget.numLesson}',
        titleBody: 'Conversación',
        body: FutureBuilder(
            future:
                _contentData.getConversation(widget.numLevel, widget.numLesson),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return FutureBuilder(
                    future: _storage.getVideoURL(snapshot.data),
                    builder: (c, s) {
                      if (s.hasData) {
                        return ComponentConversation(
                          videoURL: s.data,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
