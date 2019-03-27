import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neng/components/bottom_sheet_view.dart';
import 'package:neng/components/city_picker.dart';
import 'package:neng/components/cupertino_date_picker.dart';
import 'package:neng/model/user.dart';
import 'package:neng/service/user_service.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/load.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/info/user_detail_pages/update_nickname.dart';
import 'package:neng/view/info/user_detail_pages/update_sign.dart';

class UserDetailPage extends StatefulWidget {

  UserModel _userModel;

  UserDetailPage(this._userModel);

  @override
  State<StatefulWidget> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  UserService _userService;

  Widget initTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('个人信息',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Widget initPhoto() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
          height: 260.0,
          width: 160.0,
          child: ClipOval(
              child: CircleAvatar(
                radius: 36.0,
                backgroundImage: CachedNetworkImageProvider(
                  GlobalConfig.imageUrlBase + widget._userModel.photo,
                ),
              )
          ),
        ),
        Positioned(
          bottom: 60.0,
          right: 10.0,
          child: GestureDetector(
            child: Container(
              width: 32.0,
              height: 32.0,
              child: Image.asset('assets/icons/camera.png'),
            ),
            onTap: _getImage,
          ),
        )
      ],
    );
  }

  void _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (null == image) {
      return;
    }
    Load.openLoading(_context);
    widget._userModel.photo = await _userService.uploadImage(image);
    Load.closeLoading();
    setState(() {});
  }

  Widget initSaveBtn() {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10.0),
        width: 80.0,
        child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Color(0xFFEDF7FF),
            onPressed: _saveBtnAction,
            child: Text('保存',
              style: TextStyle(
                  color: Colors.black
              ),
            )
        )
    );
  }

  AppBar initAppBar() {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 18.0,
            onPressed: () {
              FocusScope.of(_context).requestFocus(FocusNode());
              Navigator.of(context).pop();
            },
          );
        },
      ),
      actions: <Widget>[
        initSaveBtn()
      ],
      elevation: 0.0,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
    );
  }

  Widget initLine() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      color: Color(0xFFF0F0F0),
      height: 0.5,
    );
  }

  Widget initItem(String title, String value, Function onTap) {
    return Container(
        padding: EdgeInsets.only(
            left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
        child: GestureDetector(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(title),
                flex: 2,
              ),
              Expanded(
                child: Text(value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                ),
                flex: 10,
              )
            ],
          ),
          onTap: onTap,
        )
    );
  }

  void _goUpdateNickname() {
    Router.push(_context, UpdateNicknamePage(widget._userModel.nickName)).then((String value) {
      widget._userModel.nickName = value;
    });
  }

  void _goUpdateSign() {
    Router.push(_context, UpdateSignPage(widget._userModel.sign)).then((String value) {
      widget._userModel.sign = value;
    });
  }

  void _updateSex() {
    Map<String, Function> data = Map();
    data['男'] = (){
      widget._userModel.sex = 1;
      Navigator.of(_context).pop();
      setState(() {});
    };
    data['女'] = (){
      widget._userModel.sex = 2;
      Navigator.of(_context).pop();
      setState(() {});
    };
    BottomSheetView().showBottomSheet(_context, data);
  }

  void _updateAge() {
    DatePicker.showDatePicker(
      _context,
      showTitleActions: true,
      locale: 'zh',
      minYear: 1900,
      maxYear: DateTime.now().year,
      initialYear: DateTime.now().year,
      initialMonth: DateTime.now().month,
      initialDate: DateTime.now().day,
      onChanged: (year, month, date) { },
      onConfirm: (year, month, date) {
        widget._userModel.birthday = '${year.toString()}-${month.toString()}-${date.toString()}';
        setState(() {});
      },
    );

  }

  void _updateAddress() {
    CityPicker.showCityPicker(
      _context,
      selectProvince: (province) {
        widget._userModel.province = province.toString();
      },
      selectCity: (city) {
        widget._userModel.city = city.toString();
      },
      selectArea: (area) {
        widget._userModel.area = area.toString();
      },
    );

  }

  Widget getSheetItem(String asset, String title, Function onTap) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 36.0,
              height: 36.0,
              child: Image.asset(asset),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              child: Text(title),
            ),
            flex: 10,
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _saveBtnAction() async {
    Load.openLoading(_context);
    bool updateRes = await _userService.update(widget._userModel);
    Load.closeLoading();
    if (!updateRes) {
      return;
    }
    bool refreshUserRes = await _userService.refreshUserModel();
    if (!refreshUserRes) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _userService.cancelAllHttpRequest();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _userService = UserService(_context, _scaffoldKey);
    return Scaffold(
      key: _scaffoldKey,
      appBar: initAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            initTitle(),
            initPhoto(),
            initLine(),
            initItem('昵称:', widget._userModel.nickName, _goUpdateNickname),
            initLine(),
            initItem('签名:', widget._userModel.sign, _goUpdateSign),
            initLine(),
            initItem('性别:', widget._userModel.getSexView(), _updateSex),
            initLine(),
            initItem('生日:', widget._userModel.birthday, _updateAge),
            initLine(),
            initItem('地区:', widget._userModel.area, _updateAddress),
            initLine(),
          ],
        ),
      ),
    );
  }
}
