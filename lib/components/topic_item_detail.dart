import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neng/components/record_view.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/model/topic_item_comment.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/push.dart';

class TopicItemDetailPage extends StatefulWidget {

  TopicItemModel _topicItem;

  TopicItemDetailPage(this._topicItem);

  @override
  State<StatefulWidget> createState() => _TopicItemDetailPageState();
}

class _TopicItemDetailPageState extends State<TopicItemDetailPage> {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TopicService _topicService;
  bool _isInitData = false;
  List<Widget> _commentList = List();
  TextEditingController _topicItemCommentText = TextEditingController();

  Widget initComment() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 5.0,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                color: Colors.blue,
                width: 2.0,
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  '评论',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          commentList()
        ],
      ),
    );
  }

  Widget commentList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _commentList,
      ),
    );
  }

  Widget commentCard(TopicItemCommentModel topicItemCommentModel) {
    return Container(
      child: Column(
        children: <Widget>[
          commentTitle(topicItemCommentModel),
          commentText(topicItemCommentModel),
          commentBottom(topicItemCommentModel),
          commentLine(),
        ],
      ),
    );
  }

  Widget commentLine() {
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 10.0, top: 2.5, bottom: 10.0),
      color: Color(0xFFF0F0F0),
      height: 1,
    );
  }

  Widget commentBottom(TopicItemCommentModel topicItemCommentModel) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 2.5),
      child: Text(
        topicItemCommentModel.gmtCreate,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFFDCDCDC),
        ),
      ),
    );
  }

  Widget commentText(TopicItemCommentModel topicItemCommentModel) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0),
      child: Text(
        topicItemCommentModel.text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget commentTitle(TopicItemCommentModel topicItemCommentModel) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5),
              height: 25.0,
              child: ClipOval(
                  child: CircleAvatar(
                    radius: 36.0,
                    backgroundImage: CachedNetworkImageProvider(
                        GlobalConfig.imageUrlBase + topicItemCommentModel.user.photo),
                  )
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              child: Text(
                topicItemCommentModel.user.nickName,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            flex: 9,
          ),
          Expanded(
            child: Container(
              width: 15,
              height: 15,
              child: Image.asset('assets/record/icon_feed_like_l_16x15.png'),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget initBottom() {
    return Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: <Widget>[
            LimitedBox(
                maxHeight: 80.0,
                child: SingleChildScrollView(
                  child: TextField(
                      maxLines: null,
                      controller: _topicItemCommentText,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration.collapsed(hintText: '写评论...')
                  ),
                )
            ),
            Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Text('发送'),
                  onTap: _submitComment,
                )
            ),
          ],
        )
    );
  }

  Widget initBody() {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RecordView(widget._topicItem
                , _topicService
                , showRecordTag: true
                , showDetail: false
                , isGoDetail: false
                , textMaxLines: null
            ),
            initComment(),
          ],
        ),
      ),
      fit: FlexFit.tight,
    );
  }

  Widget initMenuBtn() {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      width: 16,
      height: 16,
      child: GestureDetector(
        child: Image.asset('assets/info/icon_voice_detail_more_16x16.png'),
      ),
    );
  }


  AppBar initAppBar() {
    return AppBar(
      actions: <Widget>[
        initMenuBtn(),
      ],
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 18.0,
            onPressed: () {
              FocusScope.of(_context).requestFocus(FocusNode());
              Navigator.of(context).pop();
            },
          );
        },
      ),
      elevation: 0.0,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Text(
        "详情",
        style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            textBaseline: TextBaseline.ideographic
        ),
      ),
    );
  }

  void _initData() async {
    List<TopicItemCommentModel> list = await _topicService.topicItemCommentList(widget._topicItem.id, 1, -1);
    this._isInitData = true;
    _commentList.clear();

    List<Widget> commentList = List();
    if (list.length == 0) {
      commentList.add(Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 35.0, bottom: 35.0),
        child: Text('快来发表你的评论吧',
            style: TextStyle(color: Color(0xFFCDCDCD))
        ),
      ));
    }
    for (TopicItemCommentModel item in list) {
      commentList.add(commentCard(item));
    }
    setState(() {
      _commentList = commentList;
    });
  }

  void _submitComment() async {
    TopicItemCommentModel topicItemCommentModel = TopicItemCommentModel();
    topicItemCommentModel.text = _topicItemCommentText.text;
    topicItemCommentModel.image = '';
    topicItemCommentModel.topicId = widget._topicItem.topicId;
    topicItemCommentModel.topicItemId = widget._topicItem.id;
    topicItemCommentModel.topicItemUserId = widget._topicItem.userId;
    bool submitRes = await _topicService.topicItemCommentSubmit(topicItemCommentModel);
    if (!submitRes) {
      return;
    }
    _topicItemCommentText.text = '';
    FocusScope.of(_context).requestFocus(FocusNode());
    _initData();
    Push.pushTopReminder(GlobalConfig.mainContext, '发送成功!');
  }

  void _initBodyView() {
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 40.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 40.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 40.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 40.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 40.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _commentList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 40.0, right: 20.0),
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
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
      _initBodyView();
      _initData();
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: initAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            initBody(),
            Divider(height: 1.0),
            initBottom(),
          ],
        ),
      ),
    );
  }
}
