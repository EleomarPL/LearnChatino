import 'dart:async';
import '../database/ObjectTables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainDatabase {
  final firestore = FirebaseFirestore.instance;

  Future<List<ProgressUser>> getProgressUser(String uidUser) async {
    QuerySnapshot docsProg = await firestore
        .collection('progressUser')
        .where('uidUser', isEqualTo: uidUser)
        .orderBy('levelAdvance')
        .orderBy('lessonAdvance')
        .get();
    return docsProg.docs.map((e) => ProgressUser.toMap(e.data())).toList();
  }

  Future<void> registerInitialAdvanceLevel(
      String uidUser, int numLevels) async {
    for (int i = 0; i < numLevels; i++) {
      await firestore
          .collection('progressUser')
          .add(ProgressUser(uidUser, i + 1, 1, 0).toMap());
      await firestore
          .collection('progressUser')
          .add(ProgressUser(uidUser, i + 1, 2, 0).toMap());
      await firestore
          .collection('progressUser')
          .add(ProgressUser(uidUser, i + 1, 3, 0).toMap());
    }
  }

  Future<List<WordFavorites>> getWordFavorites(String uidUser) async {
    QuerySnapshot docsWord = await firestore
        .collection('wordFavorites')
        .where('uidUser', isEqualTo: uidUser)
        .get();
    return docsWord.docs.map((e) => WordFavorites.toMap(e.data())).toList();
  }

  Future<void> insertWordFavorite(WordFavorites word) async {
    await firestore.collection('wordFavorites').add(word.toMap());
  }

  Future<bool> existThisWordInFavorite(String uidUser, String word) async {
    QuerySnapshot docWord = await firestore
        .collection('wordFavorites')
        .where('uidUser', isEqualTo: uidUser)
        .where('wordSpanish', isEqualTo: word)
        .get();
    return (docWord.size == 0) ? false : true;
  }

  Future<void> deleteWord(String uidUser, String wordInSpanish) async {
    QuerySnapshot docWord = await firestore
        .collection('wordFavorites')
        .where('uidUser', isEqualTo: uidUser)
        .where('wordSpanish', isEqualTo: wordInSpanish)
        .get();
    await docWord.docs.first.reference.delete();
  }

  Future<void> insertExercisePassed(
      String uidUser, int numLevel, int numLesson, int numExercise) async {
    final String idExercise = '$uidUser$numLevel$numLesson$numExercise';
    if (await existThisExercise(idExercise, uidUser)) return;

    ControlExercise controlExercise = ControlExercise(idExercise, uidUser);
    await firestore.collection('exerciseControl').add(controlExercise.toMap());

    updateControlExercise(uidUser, numLevel, numLesson);
  }

  Future<void> updateControlExercise(
      String uidUser, int numLevel, int numLesson) async {
    String idPossibleToSearch = '$uidUser$numLevel$numLesson';
    QuerySnapshot docExc = await firestore
        .collection('exerciseControl')
        .where('idExercise', isGreaterThanOrEqualTo: idPossibleToSearch)
        .where('idExercise', isLessThanOrEqualTo: idPossibleToSearch + '\uf8ff')
        .get();
    QuerySnapshot docProg = await firestore
        .collection('progressUser')
        .where('uidUser', isEqualTo: uidUser)
        .where('levelAdvance', isEqualTo: numLevel)
        .where('lessonAdvance', isEqualTo: numLesson)
        .get();
    docProg.docs.first.reference.update({'exercise': docExc.size});
  }

  Future<bool> existThisExercise(String idExercise, String uidUser) async {
    QuerySnapshot docExc = await firestore
        .collection('exerciseControl')
        .where('uidUser', isEqualTo: uidUser)
        .where('idExercise', isEqualTo: idExercise)
        .get();
    return docExc.docs.isNotEmpty;
  }

  Future<void> deleteAllProgressUser(String uidUser) async {
    QuerySnapshot docProgress = await firestore
        .collection('progressUser')
        .where('uidUser', isEqualTo: uidUser)
        .get();
    docProgress.docs.forEach((element) async {
      await element.reference.delete();
    });

    QuerySnapshot docExercise = await firestore
        .collection('exerciseControl')
        .where('uidUser', isEqualTo: uidUser)
        .get();
    docExercise.docs.forEach((element) async {
      await element.reference.delete();
    });

    QuerySnapshot docWord = await firestore
        .collection('wordFavorites')
        .where('uidUser', isEqualTo: uidUser)
        .get();
    docWord.docs.forEach((element) async {
      await element.reference.delete();
    });
  }
}
