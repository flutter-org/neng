import 'package:flutter/material.dart';
import 'package:neng/components/bottom_sheet_view.dart';
import 'package:neng/components/photo_picker.dart';
import 'package:neng/components/topic_item_detail.dart';
import 'package:neng/model/topic_item.dart';
import 'package:neng/service/topic_service.dart';
import 'package:neng/utils/global.dart';
import 'package:neng/utils/load.dart';
import 'package:neng/utils/router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RecordView extends StatefulWidget {

  TopicItemModel topicItem;
  TopicService topicService;
  bool showRecordTag;
  bool showDetail;
  bool isGoDetail;
  int textMaxLines;
  double allPadding;

  RecordView(this.topicItem, this.topicService, { this.showRecordTag = false, this.showDetail = true, this.isGoDetail = true, this.textMaxLines = 6, this.allPadding = 15.0 });

  @override
  State<StatefulWidget> createState() => _RecordView();
}

class _RecordView extends State<RecordView> {

  BuildContext _context;

  void _goDetail() {
    if (widget.isGoDetail) {
      Router.push(GlobalConfig.mainContext, TopicItemDetailPage(widget.topicItem));
    }
  }

  void _praiseAction() async {
    if (widget.topicItem.praise) {
      Load.openLoading(GlobalConfig.mainContext);
      await widget.topicService.itemUnPraise(widget.topicItem.topicId, widget.topicItem.id);
      Load.closeLoading();
      if (null != widget.topicItem.countPraise) {
        widget.topicItem.countPraise--;
      }
      widget.topicItem.praise = false;
    } else {
      Load.openLoading(GlobalConfig.mainContext);
      await widget.topicService.itemPraise(widget.topicItem.topicId, widget.topicItem.id);
      Load.closeLoading();
      if (null != widget.topicItem.countPraise) {
        widget.topicItem.countPraise++;
      }
      widget.topicItem.praise = true;
    }
    setState(() {});
  }

  void _imageOnTap() {
    Router.push(GlobalConfig.mainContext, PhotoPicker(PhotoPickerType.url, imageUrl: GlobalConfig.imageUrlBase + widget.topicItem.imagePojo[0]));
  }

  Widget initRecord() {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(widget.allPadding),
        child: Column(
          children: <Widget>[
            initRecordUserInfo(),
            initRecordText(),
            initRecordImage(),
            initRecordTag(),
            initRecordImages(),
            initRecordBottom(),
            initLine(),
          ],
        ),
      ),
      onTap: () => _goDetail(),
    );
  }

  Widget initRecordUserInfo() {
    Widget detail = Container();
    if (widget.showDetail) {
      detail = Container(
        width: 16,
        height: 16,
        child: GestureDetector(
          child: Image.asset('assets/info/icon_voice_detail_more_16x16.png'),
          onTap: () {
            Map<String, Function> data = Map();
            data['关注TA'] = () {};
            BottomSheetView().showBottomSheet(GlobalConfig.mainContext, data);
          },
        ),
      );
    }
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
                    backgroundImage: CachedNetworkImageProvider(GlobalConfig.imageUrlBase + widget.topicItem.user.photo),
                  )),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              child: Text(
                widget.topicItem.user.nickName,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            flex: 10,
          ),
          Expanded(
            child: detail,
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget initRecordText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              widget.topicItem.text,
              overflow: TextOverflow.fade,
              maxLines: widget.textMaxLines,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget initRecordImage() {
    Widget imageView = Container();
    if (null != widget.topicItem.imagePojo && widget.topicItem.imagePojo.length > 0) {
      imageView = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: GestureDetector(
          child: LimitedBox(
            maxHeight: 160.0,
            child: Container(
              width: 130.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(GlobalConfig.imageUrlBase + widget.topicItem.imagePojo[0]),
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ),
          onTap: _imageOnTap,
        ),
      );
    }
    return imageView;
  }

  Widget initRecordTag() {
    if (!widget.showRecordTag) {
      return Container();
    }
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                padding: EdgeInsets.only(right: 35.0),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                textColor: Colors.blue,
                color: Color(0xFFEDF7FF),
                child: Container(
                  child: Text('# ' + widget.topicItem.topic.title),
                ),
                onPressed: () => {}),
          ),
        ],
      ),
    );
  }

  Widget initRecordImages() {
    return Container();
  }

  Widget initRecordBottom() {
    Widget praiseIcon = Container(
      width: 15,
      height: 15,
      child: Image.asset('assets/record/icon_feed_like_l_16x15.png'),
    );
    if (widget.topicItem.praise) {
      praiseIcon = Container(
        width: 15,
        height: 15,
        child: Image.asset('assets/record/icon_feed_like_h_16x15.png'),
      );
    }
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              widget.topicItem.gmtCreate,
              style: TextStyle(fontSize: 12, color: Color(0xFFCDCDCD)),
            ),
            flex: 8,
          ),
          Expanded(
            child: Wrap(
              spacing: 5.0,
              alignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Container(
                  width: 15,
                  height: 15,
                  child: Image.asset('assets/record/icon_feed_comment_16x15.png'),
                ),
                Container(
                  child: Text(widget.topicItem.countComment.toString(),
                    style: TextStyle(fontSize: 12, color: Color(0xFFCDCDCD)),
                  ),
                ),
              ],
            ),
            flex: 2,
          ),
          Expanded(
            child: GestureDetector(
              child: Wrap(
                spacing: 5.0,
                alignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  praiseIcon,
                  Container(
                    child: Text(widget.topicItem.countPraise.toString(),
                      style: TextStyle(fontSize: 12, color: Color(0xFFCDCDCD)),
                    ),
                  ),
                ],
              ),
              onTap: _praiseAction,
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget initLine() {
    return Container(
      color: Color(0xFFF0F0F0),
      height: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return initRecord();
  }

}