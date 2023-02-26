// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class ListLeaveWorkAdmin extends StatelessWidget {
  const ListLeaveWorkAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('leaveWorkModel --> ${appController.leaveWorkModels.length}');
          return appController.leaveWorkModels.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  itemCount: appController.leaveWorkModels.length,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetText(text: appController.nameOfficers[index]),
                          WidgetText(
                              text: appController.leaveWorkModels[index].leave),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              WidgetText(
                                  text: AppService().changeToFormatDateTime(
                                      dateTime: appController
                                          .leaveWorkModels[index].startDate
                                          .toDate())),
                              WidgetText(
                                  text: AppService().changeToFormatDateTime(
                                      dateTime: appController
                                          .leaveWorkModels[index].endDate
                                          .toDate())),
                            ],
                          ),
                          WidgetText(text: appController.leaveWorkModels[index].approve),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
