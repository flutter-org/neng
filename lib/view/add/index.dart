import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neng/components/photo_picker.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/service/topic_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neng/utils/load.dart';
import 'package:neng/utils/router.dart';

class AddTopicPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AddTopicState();

}

class _AddTopicState extends State<AddTopicPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TopicService _topicService;

  TextEditingController _topicItemText = TextEditingController();

  void _back() {
    Navigator.of(_context).pop();
  }

  void _submit() async {
//    TopicItemModel topicItemModel = TopicItemModel();
//    topicItemModel.topicId = widget._topicId;
//    topicItemModel.text = _topicItemText.text;
//    topicItemModel.imagePojo = _imagePaths;
//    Load.openLoading(_context);
//    bool result = await _topicService.topicItemSubmit(topicItemModel);
//    Load.closeLoading();
//    if (!result) {
//      return;
//    }
    Navigator.of(_context).pop('success');
  }

  Widget initInput() {
    return Container(
      child: TextField(
          controller: _topicItemText,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration.collapsed(hintText: '点此输入文字...')
      ),
    );
  }

  AppBar initAppBar() {
    return AppBar(
        title: Text(
          '创建话题',
          style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              textBaseline: TextBaseline.ideographic
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Image.asset('assets/add/icon_publish_attch_remove_12x12.png', width: 14.0, height: 14.0),
                onPressed: _back
            );
          },
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: false
    );
  }


  @override
  void dispose() {
    super.dispose();
    _topicService.cancelAllHttpRequest();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _topicService = TopicService(_context, _scaffoldKey);
    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: initAppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[

                ],
              ),
            ),
          )
      ),
    );
  }


}