import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:leaveworkung/models/leave_model.dart';
import 'package:leaveworkung/models/leave_work_model.dart';
import 'package:leaveworkung/models/news_model.dart';
import 'package:leaveworkung/models/user_model.dart';
import 'package:leaveworkung/states/add_profile_officer.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_dialog.dart';
import 'package:leaveworkung/widgets/widget_text_button.dart';

class AppService {
  Future<void> processInsertLeaveWork(
      {required LeaveWorkModel leaveWorkModel}) async {
    var user = FirebaseAuth.instance.currentUser;
    AppController appController = Get.put(AppController());
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('leavework')
        .doc()
        .set(leaveWorkModel.toMap())
        .then((value) {
      appController.chooseLeaves.clear();
      appController.chooseLeaves.add(null);
      appController.statrDateTimes.clear();
      appController.endDateTimes.clear();
      print('Insert LeaveWork Success');
      
    });
  }

  String changeToFormatDateTime({required DateTime dateTime}) {
    DateFormat dateFormat = DateFormat('dd/MMM/yyyy');
    String string = dateFormat.format(dateTime);
    return string;
  }

  Future<void> readAllLeave() async {
    AppController appController = Get.put(AppController());
    await FirebaseFirestore.instance.collection('leave').get().then((value) {
      for (var element in value.docs) {
        LeaveModel leaveModel = LeaveModel.fromMap(element.data());
        appController.leaveModels.add(leaveModel);
      }
    });
  }

  Future<void> editUser({required UserModel userModel}) async {
    var user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .update(userModel.toMap());
  }

  Future<void> findUserLogin({required BuildContext context}) async {
    AppController appController = Get.put(AppController());
    var user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      UserModel model = UserModel.fromMap(value.data()!);
      print('userModelLogin ---> ${model.toMap()}');

      appController.userModelLogins.add(model);
      if ((model.name.isEmpty) || (model.surname.isEmpty)) {
        AppDialog(context: context).normalDialog(
            title: 'Please Complete You Profile',
            actionWidget: WidgetTextButton(
              label: 'Go to Complete Profile',
              pressFunc: () {
                Get.offAll(const AddProfileOfficer());
              },
            ));
      }
    });
  }

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

    print('files on takePhoto --> ${appController.files.length}');
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
