import 'package:flutter/material.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/view/discovery/index.dart';
import 'package:neng/view/home/index.dart';
import 'package:neng/view/info/index.dart';
import 'package:neng/view/message/index.dart';

class IndexPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _IndexPageState();

}

class _IndexPageState extends State<IndexPage> {

  List<StatefulWidget> _pages = [
    HomePage(),
    DiscoveryPage(),
    MessagePage(),
    InfoPage(),
  ];

  Widget _homeIcon = Image.asset('assets/tab/icon_tab_square_h_22x22.png');
  Widget _discoveryIcon = Image.asset('assets/tab/icon_tab_care_l_22x22.png');
  Widget _messageIcon = Image.asset('assets/tab/icon_tab_message_l_22x22.png');
  Widget _infoIcon = Image.asset('assets/tab/icon_tab_me_l_22x22.png');
  Widget _plusIcon = Image.asset('assets/tab/icon_tab_release_new_36x26.png');

  var _controllerPages = PageController(
    initialPage: 0, // 底部 初始化页面 和状态
  );

  Widget _itemBottomIcon(int index, double width, double height, Widget icon) {
    return Container(
      width: width,
      height: height,
      child: IconButton(
        highlightColor: Colors.white,
        splashColor: Colors.white,
        icon: icon,
        color: Colors.white,
        onPressed: () {
          _tabOnPressed(index);
        },
      ),
    );
  }

  void _tabOnPressed(int index) {
    int pageIndex = index;
    if (index == 2) {
      return;
    }
    if (index > 2) {
      pageIndex = index - 1;
    }
    _controllerPages.jumpToPage(pageIndex);
    setState(() {
      if (index == 0) {
        _reSetIcon();
        _homeIcon = Image.asset('assets/tab/icon_tab_square_h_22x22.png');
      } else if (index == 1) {
        _reSetIcon();
        _discoveryIcon = Image.asset('assets/tab/icon_tab_care_h_22x22.png');
      } else if (index == 2) {

      } else if (index == 3) {
        _reSetIcon();
        _messageIcon = Image.asset('assets/tab/icon_tab_message_h_22x22.png');
      } else if (index == 4) {
        _reSetIcon();
        _infoIcon = Image.asset('assets/tab/icon_tab_me_h_22x22.png');
      }
    });
  }

  void _reSetIcon() {
    _homeIcon = Image.asset('assets/tab/icon_tab_square_l_22x22.png');
    _discoveryIcon = Image.asset('assets/tab/icon_tab_care_l_22x22.png');
    _messageIcon = Image.asset('assets/tab/icon_tab_message_l_22x22.png');
    _infoIcon = Image.asset('assets/tab/icon_tab_me_l_22x22.png');
  }

  @override
  void dispose() {
    // 销毁函数
    super.dispose();
    _controllerPages.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalConfig.mainContext = context;
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _controllerPages,
          children: _pages,
          physics: NeverScrollableScrollPhysics(), // 进制滑动切换
        ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _itemBottomIcon(0, 32.0, 32.0, _homeIcon),
                ),
                Expanded(
                  child: _itemBottomIcon(1, 32.0, 32.0, _discoveryIcon),
                ),
                Expanded(
                  child: _itemBottomIcon(2, 62.0, 42.0, _plusIcon),
                ),
                Expanded(
                  child: _itemBottomIcon(3, 32.0, 32.0, _messageIcon),
                ),
                Expanded(
                  child: _itemBottomIcon(4, 32.0, 32.0, _infoIcon),
                ),
              ],
            ),
          )
      ),
    );
  }


}