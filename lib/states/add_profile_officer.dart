import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaveworkung/models/user_model.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/utility/app_snackbar.dart';
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
  String? idOfficer, name, surname, divistion, position, phone;

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
                'files on addProfileOfficer ---> ${appController.files.length}');
            return ListView(
              children: [
                // displayImage(appController: appController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'ID officer :',
                      changeFunc: (p0) {
                        idOfficer = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Name :',
                      changeFunc: (p0) {
                        name = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'SurName :',
                      changeFunc: (p0) {
                        surname = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Division :',
                      changeFunc: (p0) {
                        divistion = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Position :',
                      changeFunc: (p0) {
                        position = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Phone :',
                      changeFunc: (p0) {
                        phone = p0.trim();
                      },
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
                        pressFunc: () {
                          if ((idOfficer?.isEmpty ?? true) ||
                              (name?.isEmpty ?? true) ||
                              (surname?.isEmpty ?? true) ||
                              (divistion?.isEmpty ?? true) ||
                              (position?.isEmpty ?? true) ||
                              (phone?.isEmpty ?? true)) {
                            AppSnackbar().normalSnackbar(
                                title: 'Have Space ?',
                                detail: 'Please Fill Every Blank');
                          } else {
                            UserModel newUserModel = UserModel(
                                division: divistion!,
                                idofficer: idOfficer!,
                                name: name!,
                                phone: phone!,
                                position: position!,
                                status: '/officer',
                                surname: surname!,
                                email: appController.userModelLogins.last.email,
                                password: appController
                                    .userModelLogins.last.password);

                            print('newUserModel ==> ${newUserModel.toMap()}');

                            AppService()
                                .editUser(userModel: newUserModel)
                                .then((value) {
                              Get.offAllNamed('/officer');
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget displayImage({required AppController appController}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: appController.files.isEmpty
                    ? const WidgetImage(
                        path: 'images/account.png',
                        size: 200,
                      )
                    : SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.file(appController.files.last),
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: WidgetIconButton(
                  iconData: Icons.camera,
                  tapFunc: () {
                    AppService().takePhoto(source: ImageSource.gallery);
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
