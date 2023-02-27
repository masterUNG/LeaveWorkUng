// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_dialog.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/widgets/widget_icon_button.dart';
import 'package:leaveworkung/widgets/widget_text.dart';
import 'package:leaveworkung/widgets/widget_text_button.dart';

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
                          Row(
                            children: [
                              WidgetText(
                                  text: appController
                                      .leaveWorkModels[index].approve),
                              appController.leaveWorkModels[index].approve ==
                                      'require'
                                  ? WidgetIconButton(
                                      iconData: Icons.approval,
                                      tapFunc: () {
                                        print(
                                            'click docIdUserOfficer --> ${appController.docIdUserOfficers[index]}');
                                        print(
                                            'click docIdLeaveWork --> ${appController.docIdLeaveWorks[index]}');

                                        AppDialog(context: context)
                                            .normalDialog(
                                                title: 'Confirm Approve ?',
                                                actionWidget: WidgetTextButton(
                                                  label: 'Confirm Approve',
                                                  pressFunc: () {
                                                    AppService()
                                                        .processApprove(
                                                            docIdOfficer:
                                                                appController
                                                                        .docIdUserOfficers[
                                                                    index],
                                                            docIdLeaveWork:
                                                                appController
                                                                        .docIdLeaveWorks[
                                                                    index])
                                                        .then((value) {
                                                      AppService()
                                                          .readAllLeaveworkAdmin();
                                                      Get.back();
                                                    });
                                                  },
                                                ));
                                      },
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
