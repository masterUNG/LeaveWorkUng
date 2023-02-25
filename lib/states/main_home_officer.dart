import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/bodys/body_home_officer.dart';
import 'package:leaveworkung/bodys/leavework_officer.dart';
import 'package:leaveworkung/bodys/list_news_officer.dart';
import 'package:leaveworkung/bodys/list_notification_officer.dart';
import 'package:leaveworkung/bodys/profile_officer.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class MainHomeOfficer extends StatefulWidget {
  const MainHomeOfficer({super.key});

  @override
  State<MainHomeOfficer> createState() => _MainHomeOfficerState();
}

class _MainHomeOfficerState extends State<MainHomeOfficer> {
  var titles = <String>[
    'Home',
    'Leave',
    'News',
    'Noti',
    'Profile',
  ];
  var iconDatas = <IconData>[
    Icons.home,
    Icons.work_off_outlined,
    Icons.newspaper,
    Icons.notifications_outlined,
    Icons.person_outline,
  ];
  var bodys = <Widget>[
    const BodyHomeOfficer(),
    const LeaveworkOfficer(),
    const ListNewsOfficer(),
    const ListNotificationOfficer(),
    const ProfileOfficer(),
  ];

  var bottonNavItems = <BottomNavigationBarItem>[];

  @override
  void initState() {
    super.initState();

    AppService().findUserLogin(context: context);
    AppService().readNews();

    for (var i = 0; i < titles.length; i++) {
      bottonNavItems.add(
        BottomNavigationBarItem(
          icon: Icon(iconDatas[i]),
          label: titles[i],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('indexBodyOfficer ---> ${appController.indexBodyOfficer}');
          return Scaffold(
            appBar: AppBar(
              title: WidgetText(
                text: titles[appController.indexBodyOfficer.value],
                textStyle: AppConstant().h2Style(),
              ),
            ),
            body: bodys[appController.indexBodyOfficer.value],
            bottomNavigationBar: BottomNavigationBar(
              items: bottonNavItems,
              onTap: (value) {
                appController.indexBodyOfficer.value = value;
              },
              currentIndex: appController.indexBodyOfficer.value,
              type: BottomNavigationBarType.fixed,
            ),
          );
        });
  }
}
