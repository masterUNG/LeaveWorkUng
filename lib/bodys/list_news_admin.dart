import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/states/add_news.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/widgets/widget_button.dart';
import 'package:leaveworkung/widgets/widget_image_network.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class ListNewsAdmin extends StatefulWidget {
  const ListNewsAdmin({super.key});

  @override
  State<ListNewsAdmin> createState() => _ListNewsAdminState();
}

class _ListNewsAdminState extends State<ListNewsAdmin> {
  @override
  void initState() {
    super.initState();
    AppService().readNews();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('newsModels --> ${appController.newsModels.length}');
            return SizedBox(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight,
              child: Stack(
                children: [
                  appController.newsModels.isEmpty
                      ? const SizedBox()
                      : ListView.builder(
                          itemCount: appController.newsModels.length,
                          itemBuilder: (context, index) => Row(
                            children: [
                              Container(
                                width: boxConstraints.maxWidth * 0.5,
                                height: boxConstraints.maxWidth * 0.4,
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                child: WidgetImageNetwork(
                                  url: appController.newsModels[index].urlImage,
                                  boxFit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: boxConstraints.maxWidth * 0.5,
                                height: boxConstraints.maxWidth * 0.4,
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                child: WidgetText(
                                    text:
                                        appController.newsModels[index].title, textStyle: AppConstant().h2Style(size: 18),),
                              ),
                            ],
                          ),
                        ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: WidgetButton(
                      label: 'Add News',
                      pressFunc: () {
                        Get.to(const AddNews());
                      },
                    ),
                  )
                ],
              ),
            );
          });
    });
  }
}
