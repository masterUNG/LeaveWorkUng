import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/models/leave_work_model.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/utility/app_snackbar.dart';
import 'package:leaveworkung/widgets/widget_button.dart';
import 'package:leaveworkung/widgets/widget_icon_button.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class LeaveworkOfficer extends StatefulWidget {
  const LeaveworkOfficer({super.key});

  @override
  State<LeaveworkOfficer> createState() => _LeaveworkOfficerState();
}

class _LeaveworkOfficerState extends State<LeaveworkOfficer> {
  DateTime currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('leaveModels ---> ${appController.leaveModels.length}');
          return ListView(
            children: [
              appController.leaveModels.isEmpty
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          child: DropdownButton(
                            isExpanded: true,
                            hint: const WidgetText(
                                text: 'โปรดเลือกเหตุผลของการลา'),
                            value: appController.chooseLeaves.last,
                            items: appController.leaveModels
                                .map(
                                  (element) => DropdownMenuItem(
                                    child: WidgetText(text: element.leave),
                                    value: element.leave,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              appController.chooseLeaves.add(value);
                            },
                          ),
                        ),
                      ],
                    ),
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: WidgetText(
                  text: 'Start Date',
                  textStyle: AppConstant().h2Style(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetText(
                    text: appController.statrDateTimes.isEmpty
                        ? 'dd/MM/yyyy'
                        : AppService().changeToFormatDateTime(
                            dateTime: appController.statrDateTimes.last!),
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetIconButton(
                    iconData: Icons.calendar_month,
                    tapFunc: () async {
                      await showDatePicker(
                              context: context,
                              initialDate: currentDateTime,
                              firstDate: DateTime(currentDateTime.year),
                              lastDate: DateTime(currentDateTime.year + 1))
                          .then((value) {
                        appController.statrDateTimes.add(value);
                      });
                    },
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: WidgetText(
                  text: 'End Date',
                  textStyle: AppConstant().h2Style(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetText(
                    text: appController.endDateTimes.isEmpty
                        ? 'dd/MM/yyyy'
                        : AppService().changeToFormatDateTime(
                            dateTime: appController.endDateTimes.last!),
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetIconButton(
                    iconData: Icons.calendar_month,
                    tapFunc: () async {
                      await showDatePicker(
                              context: context,
                              initialDate: currentDateTime,
                              firstDate: DateTime(currentDateTime.year),
                              lastDate: DateTime(currentDateTime.year + 1))
                          .then((value) {
                        appController.endDateTimes.add(value);
                      });
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 64),
                    child: WidgetButton(
                      label: 'ขอลา',
                      pressFunc: () {
                        if (appController.chooseLeaves.last == null) {
                          AppSnackbar().normalSnackbar(
                              title: 'เหตุผลของการลา ?',
                              detail: 'กรุณาเลือกเหตุผลด้วย');
                        }
                        if (appController.statrDateTimes.isEmpty) {
                          AppSnackbar().normalSnackbar(
                              title: 'Start Date ?',
                              detail: 'Please Tap Calender Start Date');
                        }
                        if (appController.endDateTimes.isEmpty) {
                          AppSnackbar().normalSnackbar(
                              title: 'End Date ?',
                              detail: 'Please Tap Calender End Date');
                        } else {
                          LeaveWorkModel leaveWorkModel = LeaveWorkModel(
                              approve: 'require',
                              leave: appController.chooseLeaves.last!,
                              startDate: Timestamp.fromDate(
                                  appController.statrDateTimes.last!),
                              endDate: Timestamp.fromDate(
                                  appController.endDateTimes.last!),
                              recordDate: Timestamp.fromDate(DateTime.now()));

                          print(
                              'leaveWorkModel ---> ${leaveWorkModel.toMap()}');
                          AppService()
                              .processInsertLeaveWork(
                                  leaveWorkModel: leaveWorkModel)
                              .then((value) {
                            appController.indexBodyOfficer.value = 0;
                          });
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
