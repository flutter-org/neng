import 'package:flutter/material.dart';
import 'package:neng/components/record_view.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/model/topic_item_list.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/push.dart';
import 'package:neng/view/add/index.dart';

class TopicItemListPage extends StatefulWidget {

  int _topicId;
  String _topicTitle;

  TopicItemListPage(this._topicId, this._topicTitle);

  @override
  State<StatefulWidget> createState() =>
      _TopicItemListPageState();
}

class _TopicItemListPageState extends State<TopicItemListPage> with TickerProviderStateMixin {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TopicService _topicService;
  int _page = 1;
  int _size = 20;
  int _total = 0;
  bool _isInitData = false;
  List _recordList = List();
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isEnd = false;
  TabController _tabController;

  Future _onRefresh() async {
    _page = 1;
    TopicItemListModel topicItemListModel = await _topicService.topicItemList(widget._topicId, this._page, this._size);
    _recordList.clear();

    List<Widget> list = List();
    if (topicItemListModel.items.length == 0) {
      _isEnd = true;
      list.add(Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Text('还没有人发布话题哦',
            style: TextStyle(color: Color(0xFFCDCDCD))
        ),
      ));
    }
    for (TopicItemModel topicItem in topicItemListModel.items) {
      list.add(RecordView(topicItem, _topicService));
    }
    if (topicItemListModel.items.length <= _size) {
      _isEnd = true;
      list.add(Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Text('没有更多了',
            style: TextStyle(color: Color(0xFFCDCDCD))
        ),
      ));
    }

    setState(() {
      _isEnd = false;
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
    if (_isLoading || _isEnd) {
      return;
    }
    _isLoading = true;
    _page++;
    TopicItemListModel topicItemListModel = await _topicService.topicItemList(widget._topicId, this._page, this._size);

    List<Widget> list = List();
    if (topicItemListModel.items.length == 0) {
      _isEnd = true;
      list.add(Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Text('没有更多了',
            style: TextStyle(color: Color(0xFFCDCDCD))
        ),
      ));
    }
    for (TopicItemModel topicItem in topicItemListModel.items) {
      list.add(RecordView(topicItem, _topicService));
    }

    setState(() {
      _isLoading = false;
      _recordList.addAll(list);
    });
  }

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
        tabs: <Widget>[
          Tab(
            child: Container(
              child: Text('最新',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              child: Text('热帖',
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
        _onRefresh();
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
    _context = context;
    _topicService = TopicService(_context, _scaffoldKey);
    if (!_isInitData) {
      _initBodyView();
      _initData();
    }
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addView,
        highlightElevation: 10.0,
        backgroundColor: Color(0xFF87CEFA),
        child: Image.asset('assets/icons/pen.png', width: 32.0, height: 32.0),
      ),
    );
  }

}
