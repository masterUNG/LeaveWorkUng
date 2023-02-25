// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:leaveworkung/models/news_model.dart';
import 'package:leaveworkung/utility/app_constant.dart';
import 'package:leaveworkung/widgets/widget_image_network.dart';
import 'package:leaveworkung/widgets/widget_text.dart';

class DisplayDetailNews extends StatelessWidget {
  const DisplayDetailNews({
    Key? key,
    required this.newsModel,
  }) : super(key: key);

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          WidgetText(
            text: newsModel.title,
            textStyle: AppConstant().h2Style(),
          ),
          WidgetImageNetwork(url: newsModel.urlImage),
          WidgetText(text: newsModel.detail)
        ],
      ),
    );
  }
}
