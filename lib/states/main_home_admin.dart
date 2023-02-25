import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/bodys/list_news_admin.dart';
import 'package:leaveworkung/bodys/list_officer_admin.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class MainHomeAdmin extends StatefulWidget {
  const MainHomeAdmin({super.key});

  @override
  State<MainHomeAdmin> createState() => _MainHomeAdminState();
}

class _MainHomeAdminState extends State<MainHomeAdmin> {
  var titles = <String>[
    'Officer',
    'News',
  ];

  var iconDatas = <IconData>[
    Icons.person,
    Icons.newspaper,
  ];

  var bodys = <Widget>[
    const ListOfficerAdmin(),
    const ListNewsAdmin(),
  ];

  var bottonNavBarItems = <BottomNavigationBarItem>[];

  @override
  void initState() {
    super.initState();

    AppService().findUserLogin(context: context).then((value) {
      AppService().setupMessage();
    });

    for (var i = 0; i < titles.length; i++) {
      bottonNavBarItems.add(
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
          print('indexBody --> ${appController.indexBodyAdmin}');
          return Scaffold(
            appBar: AppBar(
              title: WidgetText(
                text: titles[appController.indexBodyAdmin.value],
                textStyle: AppConstant().h2Style(),
              ),
            ),
            body: bodys[appController.indexBodyAdmin.value],
            bottomNavigationBar: BottomNavigationBar(
              items: bottonNavBarItems,
              currentIndex: appController.indexBodyAdmin.value,
              onTap: (value) {
                appController.indexBodyAdmin.value = value;
              },
            ),
          );
        });
  }
}
