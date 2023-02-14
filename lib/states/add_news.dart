import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaveworkung/models/news_model.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/utility/app_snackbar.dart';
import 'package:leaveworkung/widgets/widget_button.dart';
import 'package:leaveworkung/widgets/widget_form.dart';
import 'package:leaveworkung/widgets/widget_icon_button.dart';
import 'package:leaveworkung/widgets/widget_image.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  String? title, detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: 'Add News',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('files --> ${appController.files.length}');
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () =>
                  FocusScope.of(context).requestFocus(FocusScopeNode()),
              child: ListView(
                children: [
                  displayImage(appController: appController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetForm(
                        hint: 'Title :',
                        changeFunc: (p0) {
                          title = p0.trim();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetForm(
                        hint: 'Detail :',
                        changeFunc: (p0) {
                          detail = p0.trim();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        margin: const EdgeInsets.only(top: 16),
                        child: WidgetButton(
                          label: 'Add News',
                          pressFunc: () {
                            if (appController.files.isEmpty) {
                              AppSnackbar().normalSnackbar(
                                  title: 'No Photo ?',
                                  detail: 'Please Take Photo');
                            } else if ((title?.isEmpty ?? true) ||
                                (detail?.isEmpty ?? true)) {
                              AppSnackbar().normalSnackbar(
                                  title: 'Have Space ?',
                                  detail: 'Please Fill Every Blank');
                            } else {
                              AppService()
                                  .uploadImage(path: 'news')
                                  .then((value) async {
                                print(
                                    'urlImage ---> ${appController.urlImage}');

                                NewsModel model = NewsModel(
                                    urlImage: appController.urlImage.value,
                                    title: title!,
                                    detail: detail!,
                                    timestamp:
                                        Timestamp.fromDate(DateTime.now()));

                                await FirebaseFirestore.instance
                                    .collection('news')
                                    .doc()
                                    .set(model.toMap())
                                    .then((value) {
                                  appController.files.clear();
                                  AppService().readNews();
                                  Get.back();
                                });
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Row displayImage({required AppController appController}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: appController.files.isEmpty
                    ? const WidgetImage(
                        path: 'images/image.png',
                        size: 250,
                      )
                    : Image.file(appController.files.last),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: WidgetIconButton(
                  iconData: Icons.add_photo_alternate,
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
