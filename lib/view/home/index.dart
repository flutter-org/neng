import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:neng/model/banner.dart';
import 'package:neng/model/topic.dart';
import 'package:neng/model/topic_group.dart';
import 'package:neng/service/banner_service.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/router.dart';
import 'package:neng/view/discovery/search.dart';
import 'package:neng/view/home/topic_item_list.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  BuildContext _context;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TopicService _topicService;
  BannerService _bannerService;
  Widget _body;
  List<BannerModel> _banners;
  bool _isLoadData = false;

  Widget initLine() {
    return Container(
      color: Color(0xFFF0F0F0),
      height: 1,
    );

  }

  Widget initBanner(List<BannerModel> banners) {
    _banners = banners;
    return Container(
      color: Colors.white,
      height: 180.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: _banners[index].image,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        itemCount: _banners.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }

  Widget initBody(List<TopicGroupModel> topicGroupModels) {
    List<Widget> topicGroups = List<Widget>();
    for (TopicGroupModel item in topicGroupModels) {
      topicGroups.add(initTopicGroup(item));
    }
    return Container(
      color: Colors.white,
      child: Column(
        children: topicGroups,
      ),
    );
  }

  Widget initTopicGroup(TopicGroupModel topicGroup) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          initTopicGroupTitle(topicGroup.title, topicGroup.id),
          initTopicList(topicGroup.topicModelList)
        ],
      ),
    );
  }

  Widget initTopicGroupTitle(String title, int id) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFB4B4B4)
              ),
            ),
          ),
          Expanded(
            child: Text(
              '更多',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFB4B4B4)
              ),
            ),
            flex: 0,
          )
        ],
      ),
    );
  }

  Widget initTopicList(List<TopicModel> topicModels) {
    List<Widget> topicCards = List<Widget>();
    for (TopicModel item in topicModels) {
      topicCards.add(topicCard(item));
    }
    return Container(
      child: Column(
        children: topicCards
      ),
    );

  }

  Widget topicCard(TopicModel item) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: Text(
                '${item.topicBrowseCount} 次浏览',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB4B4B4)
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () => _topicCardOpTap(item.id, item.title),
    );
  }

  void _topicCardOpTap(int id, String title) {
    Router.push(_context, TopicItemListPage(id, title));
  }

  void _initData() async {
    List<TopicGroupModel> topicGroupList = await _topicService.topicListWithGroup();
    List<BannerModel> bannerList = await _bannerService.bannerList();

    _isLoadData = true;

    setState(() {
      _body = SingleChildScrollView(
        child: Column(
          children: <Widget>[
            initBanner(bannerList),
            initBody(topicGroupList),
          ],
        ),
      );
    });

  }

  void _initBodyView() {
    _body = SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: 142.0,
              height: 32.0,
              child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
            ),
            Container(
              child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: 142.0,
              height: 32.0,
              child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
            ),
            Container(
              child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: 142.0,
              height: 32.0,
              child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
            ),
            Container(
              child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: 142.0,
              height: 32.0,
              child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
            ),
            Container(
              child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: 142.0,
              height: 32.0,
              child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
            ),
            Container(
              child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: 142.0,
              height: 32.0,
              child: Image.asset('assets/record/icon_square_init_top_142x32.png'),
            ),
            Container(
              child: Image.asset('assets/record/icon_square_init_content_345x80.png'),
            ),
          ],
        ),
      ),
    );
  }

  AppBar initAppBar() {
    return AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: GestureDetector(
          child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 30.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Icon(Icons.search,
                      color: Color(0xFFAAAAAA),
                      size: 14.0,
                    ),
                  ),
                  Container(
                    child: Text('搜索话题',
                      style: TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 14.0
                      ),
                    ),
                  )
                ],
              )
          ),
          onTap: _goSearch,
        )
    );
  }

  void _goSearch() {
    Router.push(_context, DiscoverySearchPage());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _bannerService.cancelAllHttpRequest();
    _topicService.cancelAllHttpRequest();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _context = context;
    _topicService = TopicService(_context, _scaffoldKey);
    _bannerService = BannerService(_context, _scaffoldKey);
    if (!_isLoadData) {
      _initBodyView();
      _initData();
    }
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: initAppBar(),
        body: _body
      ),
    );
  }


}