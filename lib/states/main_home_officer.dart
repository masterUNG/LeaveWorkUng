import 'package:flutter/material.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/utility/app_service.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class MainHomeOfficer extends StatefulWidget {
  const MainHomeOfficer({super.key});

  @override
  State<MainHomeOfficer> createState() => _MainHomeOfficerState();
}

class _MainHomeOfficerState extends State<MainHomeOfficer> {
  @override
  void initState() {
    super.initState();
    AppService().findUserLogin(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: 'Main Home Officer',
          textStyle: AppConstant().h2Style(),
        ),
      ),
    );
  }
}
