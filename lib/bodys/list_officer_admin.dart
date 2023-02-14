import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/states/add_new_officer.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_controller.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/widgets/widget_button.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class ListOfficerAdmin extends StatefulWidget {
  const ListOfficerAdmin({super.key});

  @override
  State<ListOfficerAdmin> createState() => _ListOfficerAdminState();
}

class _ListOfficerAdminState extends State<ListOfficerAdmin> {
  @override
  void initState() {
    super.initState();
    AppService().readOfficerUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('userModels ---->>> ${appController.userModels.length}');
            return SizedBox(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight,
              child: Stack(
                children: [
                  appController.userModels.isEmpty
                      ? const SizedBox()
                      : ListView.builder(
                          itemCount: appController.userModels.length,
                          itemBuilder: (context, index) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WidgetText(
                                      text: appController.userModels[index].email, textStyle: AppConstant().h2Style(size: 16),),
                                  WidgetText(
                                    text: appController.userModels[index].password,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: WidgetButton(
                      label: 'Add New Officer',
                      pressFunc: () {
                        Get.to(const AddNewOfficer());
                      },
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
