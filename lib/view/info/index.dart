import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neng/components/record_view.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/info/setting.dart';
import 'package:neng/view/info/user_detail.dart';

class InfoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _InfoPageState();

}

class _InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TopicService _topicService;
  bool _isInitData = false;
  List _recordList = List();
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isEnd = false;
  int _size = 20;
  int _page = 1;

  Widget initUserInfo() {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    GlobalConfig.loginUserModel.nickName,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                initInfo()
              ],
            ),
            flex: 9,
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.only(right: 5),
                height: 80.0,
                child: ClipOval(
                    child: CircleAvatar(
                      radius: 36.0,
                      backgroundImage: CachedNetworkImageProvider(
                        GlobalConfig.imageUrlBase + GlobalConfig.loginUserModel.photo,
                      ),
                    )
                ),
              ),
              onTap: _goUserDetail,
            ),
            flex: 3,
          )
        ],
      ),
    );
  }

  Widget initInfo() {
    String sex;
    if (GlobalConfig.loginUserModel.sex == 0) {
      sex = 'assets/icons/sex.png';
    } else if (GlobalConfig.loginUserModel.sex == 1) {
      sex = 'assets/icons/man.png';
    } else if (GlobalConfig.loginUserModel.sex == 2) {
      sex = 'assets/icons/woman.png';
    }
    String address;
    if (GlobalConfig.loginUserModel.city == '') {
      address = '地址未知';
    } else {
      address = GlobalConfig.loginUserModel.city;
    }
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 5.0,
        children: <Widget>[
          Container(
            width: 16.0,
            height: 16.0,
            child: Image.asset(sex),
          ),
          Container(
            child: Text(
              '·',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFB4B4B4)
              ),
            ),
          ),
          Container(
            child: Text(
              address,
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFB4B4B4)
              ),
            ),
          ),
          Container(
            child: Text(
              '·',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFB4B4B4)
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              GlobalConfig.loginUserModel.birthday,
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFB4B4B4)
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget initSign() {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      child: Text(GlobalConfig.loginUserModel.sign,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget initLike() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
              child: Wrap(
                spacing: 5.0,
                alignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Container(
                    child: Text(
                      '0',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '收到赞',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFB4B4B4)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10.0),
              child: OutlineButton.icon(
                  onPressed: _goSetting,
                  icon: Image.asset(
                      'assets/info/icon_ucenter_setting_15x15.png', width: 18,
                      height: 18),
                  label: Text('设置'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  splashColor: Colors.white

              )
            ),
            flex: 0,
          )
        ],
      ),
    );
  }

  Widget initTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 5.0, top: 25.0),
      child: Text(
        '动态',
        style: TextStyle(),
      ),
    );
  }

  Widget initLine() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
      color: Colors.black,
      height: 2,
      width: 28.0,
    );
  }

  Future _onRefresh() async {
    _page = 1;
    List<TopicItemModel> topicItemList = await _topicService.getMyTopicItem(_page, _size);
    _recordList.clear();

    List<Widget> list = List();
    if (topicItemList.length == 0) {
      _isEnd = true;
      list.add(Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Text('您还没有在任何话题下发表动态哦',
            style: TextStyle(color: Color(0xFFCDCDCD))
        ),
      ));
    }
    for (TopicItemModel topicItem in topicItemList) {
      list.add(RecordView(topicItem, _topicService, showRecordTag: true,
          isGoDetail: true,
          allPadding: 5.0));
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
    List<TopicItemModel> topicItemList = await _topicService.getMyTopicItem(_page, _size);

    List<Widget> list = List();
    if (topicItemList.length == 0) {
      _isEnd = true;
      list.add(Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Text('没有更多了',
            style: TextStyle(color: Color(0xFFCDCDCD))
        ),
      ));
    }

    for (TopicItemModel topicItem in topicItemList) {
      list.add(RecordView(topicItem, _topicService, showRecordTag: true,
          isGoDetail: true,
          allPadding: 5.0));
    }
    setState(() {
      _isLoading = false;
      _recordList.addAll(list);
    });
  }

  Widget initTopicItemList() {
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

  void _goUserDetail() {
    Router.push(_context, UserDetailPage(GlobalConfig.loginUserModel));
  }

  void _goSetting() {
    Router.push(_context, SettingPage(GlobalConfig.loginUserModel));
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

  AppBar initAppBar() {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 0.0,
    );
  }

  void _initBodyView() {
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: 142.0,
      height: 32.0,
      child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
    ));
    _recordList.add(Container(
      alignment: Alignment.centerLeft,
      child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
    ));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _topicService.cancelAllHttpRequest();
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
          backgroundColor: Colors.white,
          appBar: initAppBar(),
          body: Container(
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    initUserInfo(),
                    initSign(),
                    initLike(),
                    initTitle(),
                    initLine(),
                    initTopicItemList(),
                  ],
                ),
              )
          )
      ),

    );
  }


}