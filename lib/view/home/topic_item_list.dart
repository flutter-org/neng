import 'package:flutter/material.dart';
import 'package:neng/components/record_view.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/model/topic_item_list.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/push.dart';
import 'package:neng/view/add/index.dart';
import 'package:neng/view/home/topic_item_list_tap.dart';

class TopicItemListPage extends StatefulWidget {

  int _topicId;
  String _topicTitle;

  TopicItemListPage(this._topicId, this._topicTitle);

  @override
  State<StatefulWidget> createState() =>
      _TopicItemListPageState();
}

class _TopicItemListPageState extends State<TopicItemListPage> with TickerProviderStateMixin {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;

  AppBar initAppBar() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
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
        widget._topicTitle,
        style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            textBaseline: TextBaseline.ideographic
        ),
      ),
      bottom: TabBar(
        labelStyle: TextStyle(
          fontSize: 18.0,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.0,
        ),
        tabs: <Widget>[
          Tab(
            child: Container(
              child: Text('最新',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              child: Text('热帖',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        indicatorSize: TabBarIndicatorSize.label,
        controller: _tabController,
      ),
    );
  }

  void _addView() {
    Navigator.of(context).push<String>(
        PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return AddPage(widget._topicId);
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
         )
    ).then((String value) {
      if ('success' == value) {
        Push.pushTopReminder(GlobalConfig.mainContext, '操作成功!');
      }
    });
  }

  SlideTransition createTransition(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: initAppBar(),
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TopicItemListTapPage(widget._topicId, TopicItemListTapType.newTopic),
          TopicItemListTapPage(widget._topicId, TopicItemListTapType.hotTopic),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addView,
        highlightElevation: 10.0,
        backgroundColor: Color(0xFFDCDCDC),
        child: Image.asset('assets/icons/pen.png', width: 32.0, height: 32.0),
      ),
    );
  }

}
