import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neng/utils/global.dart';

class NotifyPage extends StatefulWidget {

  NotifyPage();

  @override
  State<StatefulWidget> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isInitData = false;
  List _viewList = List();
  ScrollController _scrollController = ScrollController();

  Widget initTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Text('通知',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600
        ),
      ),
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

  Widget _renderRow(BuildContext context, int index) {
    return _viewList[index];
  }

  void _initData() async {
    _isInitData = true;
    _viewList.add(
      Container(
        child: Row(
          children: <Widget>[
            Container(
              child: CachedNetworkImage(imageUrl: GlobalConfig.imageUrlBase + 'user-image/28347_-1_784b6590-650f-4e51-9b7f-a4b7bda3d4a0.jpg'),
            )
          ],
        ),
      )
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
            Expanded(
              child: ListView.builder(
                itemBuilder: _renderRow,
                itemCount: _viewList.length,
                controller: _scrollController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
