class User {
  String uid;
  int type;

  User(this.uid, this.type);
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "type": type,
    };
  }
}

class WordFavorites {
  String uidUser;
  String wordSpanish;
  String wordChatino;
  String pathImage;
  String pathSound;
  WordFavorites(this.uidUser, this.wordSpanish, this.wordChatino,
      this.pathImage, this.pathSound);
  Map<String, dynamic> toMap() {
    return {
      "uidUser": uidUser,
      "wordSpanish": wordSpanish,
      "wordChatino": wordChatino,
      "pathImage": pathImage,
      "pathSound": pathSound
    };
  }

  WordFavorites.toMap(Map<String, dynamic> map) {
    uidUser = map['uidUser'];
    wordSpanish = map['wordSpanish'];
    wordChatino = map['wordChatino'];
    pathImage = map['pathImage'];
    pathSound = map['pathSound'];
  }
}

class ProgressUser {
  String uidUser;
  int levelAdavance;
  int lessonAdvance;
  int exercise;
  ProgressUser(
      this.uidUser, this.levelAdavance, this.lessonAdvance, this.exercise);
  Map<String, dynamic> toMap() {
    return {
      'uidUser': uidUser,
      'levelAdvance': levelAdavance,
      'lessonAdvance': lessonAdvance,
      'exercise': exercise
    };
  }

  ProgressUser.toMap(Map<String, dynamic> map) {
    uidUser = map['uidUser'];
    levelAdavance = map['levelAdvance'];
    lessonAdvance = map['lessonAdvance'];
    exercise = map['exercise'];
  }
}

class ControlExercise {
  String idExercise;
  String uidUser;
  ControlExercise(this.idExercise, this.uidUser);
  Map<String, dynamic> toMap() {
    return {
      'idExercise': idExercise,
      'uidUser': uidUser,
    };
  }
}
