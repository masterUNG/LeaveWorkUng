// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/utility/app_snackbar.dart';
import 'package:leaveworkung/widgets/widget_button.dart';
import 'package:leaveworkung/widgets/widget_form.dart';
import 'package:leaveworkung/widgets/widget_image.dart';
import 'package:leaveworkung/widgets/widget_logo.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const WidgetLogo(
                  title: 'Sign In',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Email :',
                      changeFunc: (p0) {
                        email = p0.trim();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Password :',
                      changeFunc: (p0) {
                        password = p0.trim();
                      },
                      obsecu: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetButton(
                      label: 'เข้าสู่ระบบ',
                      pressFunc: () async {
                        if ((email?.isEmpty ?? true) ||
                            (password?.isEmpty ?? true)) {
                          AppSnackbar().normalSnackbar(
                              title: 'Have Space',
                              detail: 'Please Fill Every Blank');
                        } else {
                          
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email!, password: password!)
                              .then((value) {
                            String uid = value.user!.uid;
                            print('uid login --> $uid');

                            AppService().findMainHome(uid: uid);
                          }).catchError((onError) {
                            AppSnackbar().normalSnackbar(
                                title: onError.code, detail: onError.message);
                          });
                        }
                      },
                      size: 250,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetText(text: 'AMARIN Book\n      Center'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
