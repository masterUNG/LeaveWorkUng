import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/widgets/widget_button.dart';
import 'package:leaveworkung/widgets/widget_form.dart';
import 'package:leaveworkung/widgets/widget_icon_button.dart';
import 'package:leaveworkung/widgets/widget_image.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class AddProfileOfficer extends StatefulWidget {
  const AddProfileOfficer({super.key});

  @override
  State<AddProfileOfficer> createState() => _AddProfileOfficerState();
}

class _AddProfileOfficerState extends State<AddProfileOfficer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: 'Add Profile',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print(
                'userModel ---> ${appController.userModelLogins.last.toMap()}');
            return ListView(
              children: [
                displayImage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'ID officer :',
                      changeFunc: (p0) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Name :',
                      changeFunc: (p0) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'SurName :',
                      changeFunc: (p0) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Division :',
                      changeFunc: (p0) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Position :',
                      changeFunc: (p0) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Phone :',
                      changeFunc: (p0) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 32),
                      width: 250,
                      child: WidgetButton(
                        label: 'Save Profile',
                        pressFunc: () {},
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget displayImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WidgetImage(
                  path: 'images/account.png',
                  size: 200,
                ),
              ),
              Positioned(bottom: 0,right: 0,
                child: WidgetIconButton(
                  iconData: Icons.camera,
                  tapFunc: () {},
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
