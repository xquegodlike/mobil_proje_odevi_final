import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobil_dersi_projesi/core/services/storage_base.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference _reference;

  @override
  Future<String> uploadFile(
      String userID, String fileType, File yuklenecekDosya) async {
    _reference = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child("profil_foto.png");
    UploadTask _uploadTask = _reference.putFile(yuklenecekDosya);

    var url = await _uploadTask.storage.ref().getDownloadURL();

    return url;
  }
}