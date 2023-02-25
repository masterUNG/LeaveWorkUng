// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/states/display_detail_news.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/widgets/widget_image_network.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class ListNewsOfficer extends StatelessWidget {
  const ListNewsOfficer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('newsModels ---> ${appController.newsModels.length}');
            return ListView.builder(
              itemCount: appController.newsModels.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(DisplayDetailNews(
                      newsModel: appController.newsModels[index]));
                },
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        width: boxConstraints.maxWidth * 0.5 - 4,
                        height: boxConstraints.maxWidth * 0.4,
                        child: WidgetImageNetwork(
                          url: appController.newsModels[index].urlImage,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          width: boxConstraints.maxWidth * 0.5 - 4,
                          height: boxConstraints.maxWidth * 0.4,
                          child: WidgetText(
                              text: appController.newsModels[index].title))
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
