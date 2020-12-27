class User {
  //int idUser;
  String nameUser;
  String userUser;
  int typeUser;
  User(this.nameUser, this.userUser, this.typeUser);
  Map<String, dynamic> toMap() {
    return {
      "nameUser": nameUser,
      "userUser": userUser,
      "typeUser": typeUser,
    };
  }
}

class WordFavorites {
  String wordSpanish;
  String wordChatino;
  String pathImage;
  String pathSound;
  WordFavorites(
      this.wordSpanish, this.wordChatino, this.pathImage, this.pathSound);
  Map<String, dynamic> toMap() {
    return {
      "wordSpanish": wordSpanish,
      "wordChatino": wordChatino,
      "pathImage": pathImage,
      "pathSound": pathSound
    };
  }
}

class ProgressUser {
  int idUser;
  int levelAdavance;
  int lessonAdvance;
  int exercise;
  ProgressUser(
      this.idUser, this.levelAdavance, this.lessonAdvance, this.exercise);
  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'levelAdvance': levelAdavance,
      'lessonAdvance': lessonAdvance,
      'exercise': exercise
    };
  }

  ProgressUser.toMap(Map<String, dynamic> map) {
    idUser = map['idUser'];
    levelAdavance = map['levelAdvance'];
    lessonAdvance = map['lessonAdvance'];
    exercise = map['exercise'];
  }
}
