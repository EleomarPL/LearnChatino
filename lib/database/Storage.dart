import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  final storage = firebase_storage.FirebaseStorage.instance;

  Future<Map<String, String>> getImageAndURLSound(pathImage, pathSound) async {
    return {
      "imageURL": await storage.ref(pathImage).getDownloadURL(),
      "soundURL": await storage.ref(pathSound).getDownloadURL()
    };
  }

  Future<String> getVideoURL(path) async {
    return await storage.ref(path).getDownloadURL();
  }
}
