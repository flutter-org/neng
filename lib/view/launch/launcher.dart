import 'package:flutter/material.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/launch/login.dart';

class LauncherPage extends StatefulWidget {

  @override
  _LauncherPageState createState() => _LauncherPageState();


}

class _LauncherPageState extends State<LauncherPage> {

  BuildContext _context;

  Widget initTitle1() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '“',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget initTitle2() {
    return Container(
      child: Text(
        '十年前你说生如夏花般绚烂，十年后你却说平凡才是唯一的答案。',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }

  Widget initTitle3() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        '”',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget initAuthor() {
    return Container(
      padding: EdgeInsets.only(top: 100.0, bottom: 240.0),
      alignment: Alignment.centerLeft,
      child: Text(
        '—————— 来自网易云音乐评论',
        style: TextStyle(
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Widget initLoginBtn() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5.0)
        ),
        height: 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                height: 26.0,
                width: 15.0,
                child: Image.asset('assets/info/icon_login_phone_15x26.png'),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  '手机登录',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              flex: 6,
            ),
          ],
        ),
      ),
      onTap: _goLogin,
    );
  }

  void _goLogin() {
    Router.push(context, LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      padding: EdgeInsets.only(
          left: 30.0, top: 120.0, right: 30.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          initTitle1(),
          initTitle2(),
          initTitle3(),
          initAuthor(),
          initLoginBtn(),
        ],
      ),
    );
  }

}