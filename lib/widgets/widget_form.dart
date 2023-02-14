// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:leaveworkung/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    required this.hint,
    required this.changeFunc,
    this.obsecu,
  }) : super(key: key);

  final String hint;
  final Function(String) changeFunc;
  final bool? obsecu;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 40,
      margin: const EdgeInsets.only(top: 16),
      child: TextFormField(obscureText: obsecu ?? false,
        onChanged: changeFunc,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true,
            hintText: hint,
            hintStyle: AppConstant().h3Style(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
      ),
    );
  }
}
