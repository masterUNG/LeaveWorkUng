import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetText(
                    text: 'dd/MM/yyyy',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetIconButton(
                    iconData: Icons.calendar_month,
                    tapFunc: () {},
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetText(
                    text: 'dd/MM/yyyy',
                    textStyle: AppConstant().h2Style(),
                  ),
                  WidgetIconButton(
                    iconData: Icons.calendar_month,
                    tapFunc: () async {
                      await showDatePicker(
                          context: context,
                          initialDate: currentDateTime,
                          firstDate: DateTime(currentDateTime.year),
                          lastDate: DateTime(currentDateTime.year+1)).then((value) {
                            return null;
                          });
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetButton(
                    label: 'ขอลา',
                    pressFunc: () {},
                  ),
                ],
              )
            ],
          );
        });
  }
}
