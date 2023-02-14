import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/models/user_model.dart';
import 'package:leaveworkung/utility/app_controller.dart';

class AppService {
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
