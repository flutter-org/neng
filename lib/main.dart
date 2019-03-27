import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neng/service/user_service.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/shared_preferences2.dart';
import 'package:neng/view/index.dart';
import 'package:neng/view/launch/launcher.dart';

void main() {

  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NENG',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoadData = false;
  UserService _userService;
  Widget _body = SingleChildScrollView(
    child: Container(),
  );
  
  void _init() async {
    _isLoadData = true;
    String token = await SharedPreferences2.getString('token');
    if (null == token) {
      _updateBody();
      return;
    }
    GlobalConfig.token = token;
    bool refreshTokenRes = await _userService.refreshToken();
    if (!refreshTokenRes) {
      _updateBody();
      return;
    }
    bool refreshUserRes = await _userService.refreshUserModel();
    if (!refreshUserRes) {
      _updateBody();
      return;
    }
    _goIndex();
  }

  void _goIndex() {
    Navigator.of(_context).pushAndRemoveUntil(
        PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return IndexPage();
            },
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child,) {
              // 添加转场动画
              return FadeTransition(
                // 不透明度（`opacity`）属性，控制子组件不透明度的动画。
                opacity: animation,
                // 滑动过渡（`SlideTransition`）组件，动画组件相对于其正常位置的位置。
                // https://docs.flutter.io/flutter/widgets/SlideTransition-class.html
                child: createTransition(animation, child),
              );
            }
        ),(route) => route == null
    );
  }

  SizeTransition createTransition(Animation<double> animation, Widget child) {
    return SizeTransition(
      sizeFactor: Tween(begin: 0.0, end: 300.0).animate(animation),
      child: child,
    );
  }

  void _updateBody() {
    setState(() {
      _body = SingleChildScrollView(
        child: LauncherPage(),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    this._context = context;
    this._userService = UserService(this._context, this._scaffoldKey);
    if (!_isLoadData) {
      this._init();
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: _body,
    );
  }
}
