import 'package:flutter/material.dart';
import 'package:neng/model/topic.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/home/topic_item_list.dart';

class DiscoverySearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoverySearchPageState();
}

class _DiscoverySearchPageState extends State<DiscoverySearchPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TopicService _topicService;
  bool _isInitData = false;
  bool _topicListHide = false;
  bool _searchListHide = true;
  List _topicList = List();
  List<Widget>  _randomTopicList = List();
  ScrollController _scrollController = ScrollController();
  String _title;
  int _page = 1;


  Widget items(TopicModel topicLeft, TopicModel topicRight) {
    Widget topicRightWidget = Container();
    if (null != topicRight) {
      topicRightWidget = Expanded(
        child: Container(
          padding: EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            child: Text('# ${topicRight.title}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16
              ),
            ),
            onTap: () {
              _goTopicItenList(topicRight.id, topicRight.title);
            },
          ),
        ),
        flex: 6,
      );
    }
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                child: Text('# ${topicLeft.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                onTap: () {
                  _goTopicItenList(topicLeft.id, topicLeft.title);
                },
              )
            ),
            flex: 6,
          ),
          topicRightWidget
        ],
      ),
    );
  }

  Widget item(TopicModel topic) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  child: Text('# ${topic.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  onTap: () {
                    _goTopicItenList(topic.id, topic.title);
                  },
                )
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  child: Text('${topic.topicBrowseCount} 次浏览',
                    style: TextStyle(
                      color: Color(0xFFAAAAAA)
                    ),
                  ),
                )
            ),
            flex: 0,
          ),
        ],
      ),
    );
  }

  void searchAction(String title) async {
    _title = title;
    List<TopicModel> topicList = await _topicService.searchTopic(_title, _page, 20);
    _topicList.clear();
    for(int i = 0; i < topicList.length; i++) {
      _topicList.add(item(topicList[i]));
    }

    setState(() {
      _topicListHide = true;
      _searchListHide = false;
    });
  }

  AppBar initAppBar() {
    return AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: TextField(
                        maxLines: 1,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            hintText: '搜索话题',
                            hintStyle: TextStyle(
                              color: Color(0xFFAAAAAA),
                              fontSize: 14.0
                            ),
                            border: InputBorder.none,
                            icon: Container(
                              padding: EdgeInsets.only(top: 10.0, left: 10.0),
                              child: Icon(Icons.search,
                                color: Color(0xFFAAAAAA),
                                size: 14.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(top: 8.0)
                        ),
                        onSubmitted: searchAction,
                    ),
                  )
              ),
              flex: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Text('取消',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  onTap: _back,
                ),
              ),
              flex: 2,
            )
          ],
        )
    );
  }

  Widget topicList() {
    return Offstage(
      offstage: _topicListHide,
      child: Container(
        child: Column(
          children: _randomTopicList,
        ),
      ),
    );
  }

  Widget searchList() {
    return Expanded(
      child: Offstage(
        offstage: _searchListHide,
        child: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: _topicList.length,
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    return _topicList[index];
  }

  void _initData() async {
    _isInitData = true;

    List<TopicModel> randomTopicList = await _topicService.randomTopic(10);
    int count = (randomTopicList.length / 2).ceil();
    for(int i = 0; i < count; i++) {
      TopicModel topicLeft = randomTopicList[i * 2];
      TopicModel topicRight;
      if ((i * 2) + 1 < randomTopicList.length) {
        topicRight = randomTopicList[(i * 2) + 1];
      }
      _randomTopicList.add(items(topicLeft, topicRight));
    }

    setState(() {});
  }

  void _back() {
    Navigator.of(_context).pop();
  }

  void _goTopicItenList(int id, String title) {
    Router.push(_context, TopicItemListPage(id, title));
  }

  @override
  void dispose() {
    super.dispose();
    _topicService.cancelAllHttpRequest();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _topicService = TopicService(_context, _scaffoldKey);
    if (!_isInitData) {
      _initData();
    }
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: initAppBar(),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            children: <Widget>[
              topicList(),
              searchList(),
            ],
          ),
        ),
      ),
    );
  }

}
