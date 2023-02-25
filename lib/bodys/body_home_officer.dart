// ignore_for_file: avoid_print, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/widgets/widget_icon_button.dart';
import 'package:leaveworkung/widgets/widget_image_network.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class BodyHomeOfficer extends StatefulWidget {
  const BodyHomeOfficer({super.key});

  @override
  State<BodyHomeOfficer> createState() => _BodyHomeOfficerState();
}

class _BodyHomeOfficerState extends State<BodyHomeOfficer> {
  var titles = <String>[
    'Leave',
    'News',
    'Noti',
    'Profile',
  ];
  var iconDatas = <IconData>[
    Icons.work_off_outlined,
    Icons.newspaper,
    Icons.notifications_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('newModels ---> ${appController.newsModels.length}');
            return ListView(
              children: [
                appController.newsModels.isEmpty
                    ? const SizedBox()
                    : ImageSlideshow(
                        children: appController.newsModels
                            .map(
                              (element) => SizedBox(
                                width: boxConstraints.maxWidth,
                                child: Stack(
                                  children: [
                                    WidgetImageNetwork(
                                      url: element.urlImage,
                                      width: boxConstraints.maxWidth,
                                      boxFit: BoxFit.cover,
                                    ),
                                    WidgetText(
                                      text: element.title,
                                      textStyle: AppConstant()
                                          .h1Style(color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        isLoop: true,
                        // autoPlayInterval: 3000,
                        height: boxConstraints.maxWidth * 0.6,
                      ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: titles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) => Card(
                    child: Column(
                      children: [
                        WidgetIconButton(
                          iconData: iconDatas[index],
                          tapFunc: () {
                            print('you tap index -> $index');
                            appController.indexBodyOfficer.value = index + 1;
                          },
                        ),
                        WidgetText(
                          text: titles[index],
                          textStyle: AppConstant().h2Style(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          });
    });
  }
}
