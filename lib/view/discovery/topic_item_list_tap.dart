import 'package:flutter/material.dart';
import 'package:neng/components/record_view.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/model/topic_item_list.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/push.dart';
import 'package:neng/view/add/index.dart';

enum TopicItemListTapType {

  randomTopic,

  followTopic,
}

class TopicItemListTapPage extends StatefulWidget {

  TopicItemListTapType _topicItemListTapType;

  TopicItemListTapPage(this._topicItemListTapType);

  @override
  State<StatefulWidget> createState() =>
      _TopicItemListPageTapState();
}

class _TopicItemListPageTapState extends State<TopicItemListTapPage> with AutomaticKeepAliveClientMixin {

  BuildContext _context;
  TopicService _topicService;
  int _page = 1;
  int _size = 20;
  bool _isInitData = false;
  List _recordList = List();
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isEnd = false;

  Future _onRefresh() async {
    _page = 1;
    _isEnd = false;
    List<TopicItemModel> topicItemList;
    List<Widget> list = List();
    if (TopicItemListTapType.randomTopic == widget._topicItemListTapType) {
      topicItemList = await _topicService.randomTopicItem(this._size);
      for (TopicItemModel topicItem in topicItemList) {
        list.add(RecordView(topicItem, _topicService, showRecordTag: true, isGoDetail: true));
      }
    } else if (TopicItemListTapType.followTopic == widget._topicItemListTapType) {
      topicItemList = await _topicService.getMyFollowUserTopicItem(this._page, this._size);
      if (topicItemList.length == 0) {
        _isEnd = true;
        list.add(Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
          child: Text('您关注的用户没有发表话题哦',
              style: TextStyle(color: Color(0xFFCDCDCD))
          ),
        ));
      }
      for (TopicItemModel topicItem in topicItemList) {
        list.add(RecordView(topicItem, _topicService, showRecordTag: true, isGoDetail: true));
      }
    }
    _recordList.clear();

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
    List<TopicItemModel> topicItemList;
    List<Widget> list = List();
    if (TopicItemListTapType.randomTopic == widget._topicItemListTapType) {
      // 随机话题 不清空原数据 不校验展示是否重复
      topicItemList = await _topicService.randomTopicItem(this._size);
      for (TopicItemModel topicItem in topicItemList) {
        list.add(RecordView(topicItem, _topicService, showRecordTag: true, isGoDetail: true));
      }
    } else if (TopicItemListTapType.followTopic == widget._topicItemListTapType) {
      if (_isEnd) {
        return;
      }
      topicItemList = await _topicService.getMyFollowUserTopicItem(this._page, this._size);
      if (topicItemList.length == 0) {
        _isEnd = true;
        list.add(Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
          child: Text('您关注的用户没有发表话题哦',
              style: TextStyle(color: Color(0xFFCDCDCD))
          ),
        ));
      }
      for (TopicItemModel topicItem in topicItemList) {
        list.add(RecordView(topicItem, _topicService, showRecordTag: true, isGoDetail: true));
      }
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
    _scrollController.dispose();
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
    _topicService = TopicService(_context, null);
    if (!_isInitData) {
      _initBodyView();
      _initData();
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemBuilder: _renderRow,
        itemCount: _recordList.length,
        controller: _scrollController,
      ),
    );
  }

}
