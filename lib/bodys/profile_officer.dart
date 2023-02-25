import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class ProfileOfficer extends StatelessWidget {
  const ProfileOfficer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('userModelLogin --> ${appController.userModelLogins.length}');
          return ListView(
            children: [
              WidgetText(text: appController.userModelLogins.last.name),
              WidgetText(text: appController.userModelLogins.last.surname),
              WidgetText(text: appController.userModelLogins.last.idofficer),
             
            ],
          );
        });
  }
}
