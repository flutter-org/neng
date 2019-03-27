import 'package:flutter/material.dart';
import 'package:neng/components/message_card_view.dart';
import 'package:neng/model/topic_item_comment.dart';
import 'package:neng/service/topic_service.dart';

class CommentPage extends StatefulWidget {

  CommentPage();

  @override
  State<StatefulWidget> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TopicService _topicService;
  bool _isInitData = false;
  List _recordList = List();
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _size = 20;
  int _page = 1;

  Widget initTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10.0),
      child: Text('评论',
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

  Future _onRefresh() async {
    _page = 1;
    List<TopicItemCommentModel> topicItemCommentList = await _topicService.getMyTopicItemComment(_page, _size);

    _recordList.clear();
    List<Widget> list = List();
    for (TopicItemCommentModel topicItemComment in topicItemCommentList) {
      list.add(MessageCardView().initMessageCardView(MessageCardViewType.comment, topicItemCommentModel: topicItemComment));
    }
    setState(() {
      _isLoading = false;
      _recordList.addAll(list);
    });
  }

  Future _getMore() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;

    _page++;
    List<TopicItemCommentModel> topicItemCommentList = await _topicService.getMyTopicItemComment(_page, _size);

    List<Widget> list = List();
    for (TopicItemCommentModel topicItemComment in topicItemCommentList) {
      list.add(MessageCardView().initMessageCardView(MessageCardViewType.comment, topicItemCommentModel: topicItemComment));
    }
    setState(() {
      _isLoading = false;
      _recordList.addAll(list);
    });
  }

  Widget _renderRow(BuildContext context, int index) {
    return _recordList[index];
  }

  Widget initTopicItemCommentList() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: _recordList.length,
          controller: _scrollController,
        ),
      ),
    );
  }

  void _initData() async {
    _onRefresh();
    _isInitData = true;
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
      _initData();
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: initAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            initTitle(),
            initTopicItemCommentList(),
          ],
        ),
      ),
    );
  }
}
