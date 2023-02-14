import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaveworkung/models/news_model.dart';
import 'package:leaveworkung/models/user_model.dart';
import 'package:leaveworkung/utility/app_controller.dart';

class AppService {
  Future<void> readNews() async {
    AppController appController = Get.put(AppController());

    if (appController.newsModels.isNotEmpty) {
      appController.newsModels.clear();
    }

    await FirebaseFirestore.instance
        .collection('news')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        NewsModel model = NewsModel.fromMap(element.data());

        appController.newsModels.add(model);
      }
    });
  }

  Future<void> uploadImage({required String path}) async {
    AppController appController = Get.put(AppController());
    String nameImage = 'image${Random().nextInt(1000000)}.jpg';

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child('$path/$nameImage');
    UploadTask uploadTask = reference.putFile(appController.files.last);
    await uploadTask.whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        String urlImage = value;
        appController.urlImage.value = value;
      });
    });
  }

  Future<void> takePhoto({required ImageSource source}) async {
    AppController appController = Get.put(AppController());
    var result = await ImagePicker().pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (result != null) {
      appController.files.add(File(result.path));
    }
  }

  Future<void> readOfficerUser() async {
    AppController appController = Get.put(AppController());
    if (appController.userModels.isNotEmpty) {
      appController.userModels.clear();
    }

    await FirebaseFirestore.instance.collection('user').get().then((value) {
      for (var element in value.docs) {
        UserModel model = UserModel.fromMap(element.data());
        if (model.status == '/officer') {
          appController.userModels.add(model);
        }
      }
    });
  }

  Future<void> findMainHome({required String uid}) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get()
        .then((value) {
      UserModel model = UserModel.fromMap(value.data()!);

      Get.offAllNamed(model.status);
    });
  }
}
