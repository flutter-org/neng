import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neng/service/user_service.dart';
import 'package:neng/utils/load.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/index.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  UserService _userService;
  String sendCodeBtnText = '发送验证码';
  int wait = 60;
  bool isWait = false;
  Timer _timer;
  TextEditingController phoneInputController = TextEditingController();
  TextEditingController codeInputController = TextEditingController();

  Widget initLine() {
    return Container(
      color: Color(0xFFF0F0F0),
      height: 1,
    );
  }

  Widget initPhoneInputText() {
    return Container(
      child: TextField(
          controller: phoneInputController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: '输入手机号码',
            hintStyle: TextStyle(
              color: Color(0xFFDCDCDC),
              fontWeight: FontWeight.w600,
            ),
            border: InputBorder.none,
          )
      ),
    );
  }

  Widget initCodeInputText() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: TextField(
                  controller: codeInputController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: '输入验证码',
                    hintStyle: TextStyle(
                      color: Color(0xFFDCDCDC),
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                  )
              ),
            ),
            flex: 7,
          ),
          Expanded(
            child: Container(
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                color: Colors.black,
                child: Text(
                  sendCodeBtnText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: _sendCodeAction,
              ),
            ),
            flex: 5,
          ),
        ],
      ),
    );
  }

  Widget initLoginBtn() {
    return Container(
      padding: EdgeInsets.only(top: 80.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.black,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Text(
                  '进入新的世界',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        onPressed: _goMain,
      ),
    );
  }

  void _sendCodeAction() async {
    if (isWait) {
      return;
    }
    Load.openLoading(_context);
    bool sendCodeRes = await _userService.sendLoginCode(phoneInputController.text);
    Load.closeLoading();
    if (sendCodeRes) {
      _startTime();
    }
  }

  void _startTime() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _timer = timer;
      setState(() {
        if (wait <= 0) {
          isWait = false;
          wait = 60;
          sendCodeBtnText = '发送验证码';
          timer.cancel();
          return;
        }
        isWait = true;
        wait--;
        sendCodeBtnText = wait.toString();
      });
    });
  }

  void _goMain() async {
    Load.openLoading(_context);
    bool loginRes = await _userService.login(phoneInputController.text, codeInputController.text);
    if (!loginRes) {
      Load.closeLoading();
      return;
    }
    bool refreshUserRes = await _userService.refreshUserModel();
    if (!refreshUserRes) {
      Load.closeLoading();
      return;
    }
    Load.closeLoading();
    if (_timer.isActive) {
      _timer.cancel();
    }
    Router.push2(_context, IndexPage());
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
      title: Text(
        "登录",
        style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            textBaseline: TextBaseline.ideographic
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userService.cancelAllHttpRequest();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    this._userService = UserService(_context, _scaffoldKey);
    return Scaffold(
      key: _scaffoldKey,
      appBar: initAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(60.0),
        child: Column(
          children: <Widget>[
            initPhoneInputText(),
            initLine(),
            initCodeInputText(),
            initLine(),
            initLoginBtn()
          ],
        ),
      ),
    );
  }

}