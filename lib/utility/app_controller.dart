import 'dart:io';

import 'package:get/get.dart';
import 'package:leaveworkung/models/leave_model.dart';
import 'package:leaveworkung/models/leave_work_model.dart';
import 'package:leaveworkung/models/news_model.dart';
import 'package:leaveworkung/models/user_model.dart';

class AppController extends GetxController {
  RxInt indexBodyAdmin = 0.obs;
  RxInt indexBodyOfficer = 0.obs;
  RxList userModels = <UserModel>[].obs;
  RxList files = <File>[].obs;
  RxString urlImage = ''.obs;
  RxList newsModels = <NewsModel>[].obs;
  RxList userModelLogins = <UserModel>[].obs;

  RxList<LeaveModel> leaveModels = <LeaveModel>[].obs;
  RxList<String?> chooseLeaves = <String?>[null].obs;

  RxList<DateTime?> statrDateTimes = <DateTime?>[].obs;
  RxList<DateTime?> endDateTimes = <DateTime?>[].obs;

  RxList<UserModel> adminUserModels = <UserModel>[].obs;
  RxList<LeaveWorkModel> leaveWorkModels = <LeaveWorkModel>[].obs;
  RxList<String> nameOfficers =<String>[].obs;
  RxList<String> docIdUserOfficers =<String>[].obs;
}
