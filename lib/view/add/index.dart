import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neng/components/photo_picker.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/service/topic_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/load.dart';
import 'package:neng/utils/router.dart';

class AddPage extends StatefulWidget {

  int _topicId;

  AddPage(this._topicId);

  @override
  State<StatefulWidget> createState() => _AddPageState();

}

class _AddPageState extends State<AddPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TopicService _topicService;

  TextEditingController _topicItemText = TextEditingController();
  bool _isHideUploadImage = false;
  bool _showImage = false;
  File _image;
  List<String> _imagePaths = List();

  void _back() {
    Navigator.of(_context).pop();
  }

  void _submit() async {
    TopicItemModel topicItemModel = TopicItemModel();
    topicItemModel.topicId = widget._topicId;
    topicItemModel.text = _topicItemText.text;
    topicItemModel.imagePojo = _imagePaths;
    Load.openLoading(_context);
    bool result = await _topicService.topicItemSubmit(topicItemModel);
    Load.closeLoading();
    if (!result) {
      return;
    }
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

  Widget initUploadImage() {
    if (_isHideUploadImage) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        child: Image.asset('assets/add/upload.png', width: 120.0),
        onTap: _getImage,
      ),
    );
  }

  Widget initShowImage() {
    if (!_showImage) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
      alignment: Alignment.centerLeft,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: Image.file(_image, width: 120.0),
            onTap: _imageOnTap,
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              child: Image.asset('assets/add/close.png', width: 16.0, height: 16.0),
              onTap: _removeImage,
            ),
          )
        ],
      )
    );
  }

  AppBar initAppBar() {
    return AppBar(
        title: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                  child: GestureDetector(
                    child: Text(
                      '发布',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black
                      ),
                    ),
                    onTap: _submit,
                  )
              ),
              right: 10.0,
              top: 18.0,
            ),
          ],
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

  void _getImage() async {
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _imagePaths.clear();

    if (null == _image) {
      return;
    }
    Load.openLoading(_context);
    String imagePath = await _topicService.uploadImage(_image);
    Load.closeLoading();
    _imagePaths.add(imagePath);
    setState(() {
      _isHideUploadImage = true;
      _showImage = true;
    });
  }

  void _removeImage() {
    _image = null;
    _imagePaths.clear();

    setState(() {
      _isHideUploadImage = false;
      _showImage = false;
    });
  }

  void _imageOnTap() {
    Router.push(_context, PhotoPicker(PhotoPickerType.file, imageFile: _image));
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: MaterialApp(
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
                    initInput(),
                    initUploadImage(),
                    initShowImage(),
                  ],
                ),
              ),
            )
        ),
      ),
      onTap: () {
        FocusScope.of(_context).requestFocus(FocusNode());
      },
    );
  }


}