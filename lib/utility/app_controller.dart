import 'dart:io';

import 'package:get/get.dart';
import 'package:leaveworkung/models/news_model.dart';
import 'package:leaveworkung/models/user_model.dart';

class AppController extends GetxController {
  RxInt indexBodyAdmin = 0.obs;
  RxList userModels = <UserModel>[].obs;
  RxList files = <File>[].obs;
  RxString urlImage = ''.obs;
  RxList newsModels = <NewsModel>[].obs;

  RxList userModelLogins = <UserModel>[].obs;
}
