import 'package:flutter/material.dart';
import 'package:neng/components/record_view.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/discovery/search.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TopicService _topicService;
  bool _isInitData = false;
  List _recordList = List();
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _size = 20;
  TabController _tabController;

  AppBar initAppBar() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    return AppBar(
      title: TabBar(
        tabs: <Widget>[
          Tab(
            child: Container(
              child: Text('发现',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              child: Text('关注',
                style: TextStyle(
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

  Future _onRefresh() async {
    List<TopicItemModel> topicItemList = await _topicService.randomTopicItem(this._size);
    _recordList.clear();

    List<Widget> list = List();
    for (TopicItemModel topicItem in topicItemList) {
      list.add(RecordView(topicItem, _topicService, showRecordTag: true, isGoDetail: true));
    }

    setState(() {
      _isLoading = false;
      _recordList.addAll(list);
    });
  }

  Widget _renderRow(BuildContext context, int index) {
    return _recordList[index];
  }

  void _initData() async {
    _onRefresh();
    _isInitData = true;
  }

  Future _getMore() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    List<TopicItemModel> topicItemList = await _topicService.randomTopicItem(this._size);

    List<Widget> list = List();
    for (TopicItemModel topicItem in topicItemList) {
      list.add(RecordView(topicItem, _topicService, showRecordTag: true, isGoDetail: true));
    }

    setState(() {
      _isLoading = false;
      _recordList.addAll(list);
    });
  }

  void _initBodyView() {
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _topicService.cancelAllHttpRequest();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _context = context;
    _topicService = TopicService(_context, _scaffoldKey);
    if (!_isInitData) {
      _initBodyView();
      _initData();
    }
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: initAppBar(),
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemBuilder: _renderRow,
                itemCount: _recordList.length,
                controller: _scrollController,
              ),
            ),
            RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemBuilder: _renderRow,
                itemCount: _recordList.length,
                controller: _scrollController,
              ),
            )
          ]
        ),
      ),
    );
  }

}
