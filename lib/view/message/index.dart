import 'package:flutter/material.dart';
import 'package:neng/components/fragment_html_view.dart';
import 'package:neng/components/fragment_image_view.dart';
import 'package:neng/components/fragment_music_view.dart';
import 'package:neng/model/fragment.dart';
import 'package:neng/service/fragment_service.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/message/comment.dart';
import 'package:neng/view/message/notify.dart';
import 'package:neng/view/message/praise.dart';

class MessagePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MessagePageState();

}

class _MessagePageState extends State<MessagePage> with AutomaticKeepAliveClientMixin {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isInitData = false;
  FragmentService _fragmentService;
  List<Widget> _fragmentList = List();
  Widget _fragment = Container();

  Widget initTab() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: GestureDetector(
                child: Image.asset('assets/message/icon_message_comment_20x20.png', width: 20, height: 20),
                onTap: () {
                  Router.push(_context, CommentPage());
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GestureDetector(
                child: Image.asset('assets/message/icon_message_praise_20x20.png', width: 20, height: 20),
                onTap: () {
                  Router.push(_context, PraisePage());
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GestureDetector(
                child: Image.asset('assets/message/icon_message_system_20x20.png', width: 20, height: 20),
                onTap: () {
                  Router.push(_context, NotifyPage());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _initData() async {
    List<FragmentModel> list = await _fragmentService.fragmentList(1, 30);
    _isInitData = true;
    for (FragmentModel item in list) {
      if (item.type == 1) {
        _fragmentList.add(FragmentMusicView(item));
      } else if (item.type == 2) {
        _fragmentList.add(FragmentImageView(item));
      } else if (item.type == 3) {
        _fragmentList.add(FragmentHtmlView(item));
      }
    }
    setState(() {
      _fragment = Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 30.0),
          child: PageView.builder(
            itemCount: _fragmentList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: _fragmentList[index],
              );
            },
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _fragmentService.cancelAllHttpRequest();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _context = context;
    _fragmentService = FragmentService(_context, _scaffoldKey);
    if (!_isInitData) {
      _initData();
    }
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                '消息',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              elevation: 0.0,
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                initTab(),
                _fragment,
              ],
            ),
          )
      ),

    );
  }


}