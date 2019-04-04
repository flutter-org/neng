import 'package:flutter/material.dart';
import 'package:neng/components/record_view.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/discovery/search.dart';
import 'package:neng/view/discovery/topic_item_list_tap.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;

  AppBar initAppBar() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    return AppBar(
      title: TabBar(
        labelStyle: TextStyle(
          fontSize: 18.0,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.0,
        ),
        tabs: <Widget>[
          Tab(
            child: Container(
              child: Text('发现',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              child: Text('关注',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),
              ),
            ),
          ),
        ],
        indicatorSize: TabBarIndicatorSize.label,
        controller: _tabController,
      ),
      elevation: 0.0,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
    );
  }

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: initAppBar(),
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            TopicItemListTapPage(TopicItemListTapType.randomTopic),
            TopicItemListTapPage(TopicItemListTapType.followTopic),
          ]
        ),
      ),
    );
  }

}
