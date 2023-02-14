import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/models/user_model.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/utility/app_snackbar.dart';
import 'package:leaveworkung/widgets/widget_button.dart';
import 'package:leaveworkung/widgets/widget_form.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class AddNewOfficer extends StatefulWidget {
  const AddNewOfficer({super.key});

  @override
  State<AddNewOfficer> createState() => _AddNewOfficerState();
}

class _AddNewOfficerState extends State<AddNewOfficer> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: 'Add New Officer',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              WidgetForm(
                hint: 'Email :',
                changeFunc: (p0) {
                  email = p0.trim();
                },
              ),
              WidgetForm(
                hint: 'Password :',
                changeFunc: (p0) {
                  password = p0.trim();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              WidgetButton(
                label: 'Add New Officer',
                pressFunc: () async {
                  if ((email?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
                    AppSnackbar().normalSnackbar(
                        title: 'Have Space?', detail: 'Please Fill EveryBlank');
                  } else {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email!, password: password!)
                        .then((value) async {
                      String uid = value.user!.uid;
                      print('uidOfficer --> $uid');

                      UserModel model = UserModel(
                          division: '',
                          idofficer: '',
                          name: '',
                          phone: '',
                          position: '',
                          status: '/officer',
                          surname: '',
                          email: email!,
                          password: password!);

                      await FirebaseFirestore.instance
                          .collection('user')
                          .doc(uid)
                          .set(model.toMap())
                          .then((value) {
                            AppService().readOfficerUser().then((value) {
                              Get.back();
                            });
                          });

                    }).catchError((onError) {
                      AppSnackbar().normalSnackbar(
                          title: onError.code, detail: onError.message);
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
