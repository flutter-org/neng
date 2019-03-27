import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neng/model/user.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/info/user_detail.dart';

class SettingPage extends StatefulWidget {

  UserModel _userModel;

  SettingPage(this._userModel);

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isInitData = false;

  Widget initTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Text('设置',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Widget initPhotoUserInfo() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: 20.0),
      child: GestureDetector(
        child: Row (
          children: <Widget>[
            Expanded(
              child: Container(
                height: 55.0,
                child: ClipOval(
                    child: CircleAvatar(
                      radius: 36.0,
                      backgroundImage: CachedNetworkImageProvider(
                        GlobalConfig.imageUrlBase + GlobalConfig.loginUserModel.photo,
                      ),
                    )
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                      alignment: Alignment.centerLeft,
                      child: Text(GlobalConfig.loginUserModel.nickName,
                        style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),
                      )
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Text('编辑个人信息',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFB4B4B4)
                        ),
                      )
                  )
                ],
              ),
              flex: 10,
            ),
            Expanded(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: Image.asset('assets/icons/icon_msg_arrow_5x11.png'),
              ),
              flex: 0,
            )
          ],
        ),
        onTap: _goUserDetail,
      )
    );
  }

  void _goUserDetail() {
    Router.push(_context, UserDetailPage(GlobalConfig.loginUserModel));
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
              Navigator.of(context).pop();
            },
          );
        },
      ),
      elevation: 0.0,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
    );
  }

  Widget initLine() {
    return Container(
      color: Color(0xFFF0F0F0),
      height: 5,
    );
  }

  Widget initItem(String title, Function onTap) {
    return Container(
        padding: EdgeInsets.only(
            left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
        child: GestureDetector(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(title),
              ),
              Expanded(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: Image.asset('assets/icons/icon_msg_arrow_5x11.png'),
                ),
                flex: 0,
              )
            ],
          ),
          onTap: onTap,
        )
    );
  }

  void _initData() async {

  }

  Widget getSheetItem(String asset, String title) {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    if (!_isInitData) {
      _initData();
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: initAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            initTitle(),
            initPhotoUserInfo(),
            initLine(),
            initItem('我关心的', () {}),
            initLine(),
            initItem('账号管理', () {}),
            initItem('黑名单管理', () {}),
            initLine(),
            initItem('清除缓存', () {}),
            initItem('意见反馈', () {}),
            initItem('关于我们', () {}),
          ],
        ),
      ),
    );
  }
}
