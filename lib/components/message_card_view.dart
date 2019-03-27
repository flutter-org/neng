import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neng/model/topic_item_comment.dart';
import 'package:neng/model/topic_item_praise.dart';
import 'package:neng/utils/global.dart';

enum MessageCardViewType {

  comment,

  praise,
}

class MessageCardView {

  MessageCardViewType _messageCardViewType;
  TopicItemCommentModel _topicItemCommentModel;
  TopicItemPraiseModel _topicItemPraiseModel;
  
  Widget initMessageCardView(MessageCardViewType messageCardViewType, {TopicItemCommentModel topicItemCommentModel, TopicItemPraiseModel topicItemPraiseModel}) {
    _messageCardViewType = messageCardViewType;
    _topicItemCommentModel = topicItemCommentModel;
    _topicItemPraiseModel = topicItemPraiseModel;
    
    return Container(
      child: Column(
        children: <Widget>[
          userInfo(),
          commentText(),
          topicItemCard(),
          initLine(),
        ],
      ),
    );
    
  }

  Widget initLine() {
    return Container(
      color: Color(0xFFF0F0F0),
      height: 0.5,
    );
  }
  
  Widget topicItemCard() {
    String photoUrl;
    String nickName;
    String text;
    if (_messageCardViewType == MessageCardViewType.comment) {
      photoUrl = _topicItemCommentModel.topicItem.user.photo;
      nickName = _topicItemCommentModel.topicItem.user.nickName;
      text = _topicItemCommentModel.topicItem.text;
    } else if (_messageCardViewType == MessageCardViewType.praise) {
      photoUrl = _topicItemPraiseModel.topicItem.user.photo;
      nickName = _topicItemPraiseModel.topicItem.user.nickName;
      text = _topicItemPraiseModel.topicItem.text;
    }
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
      height: 60.0,
      decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 60.0,
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0)),
              image: DecorationImage(
                image: CachedNetworkImageProvider(GlobalConfig.imageUrlBase + photoUrl),
              )
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(nickName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Container(
                    child: Text(text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  
  Widget commentText() {
    String text;
    if (_messageCardViewType == MessageCardViewType.comment) {
      text = '评论：${_topicItemCommentModel.text}';
    } else if (_messageCardViewType == MessageCardViewType.praise) {
      text = '赞了你的话题';
    }
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
  
  Widget userInfo() {
    String photoUrl;
    String nickName;
    String gmtCreate;
    if (_messageCardViewType == MessageCardViewType.comment) {
      photoUrl = _topicItemCommentModel.user.photo;
      nickName = _topicItemCommentModel.user.nickName;
      gmtCreate = _topicItemCommentModel.gmtCreate;
    } else if (_messageCardViewType == MessageCardViewType.praise) {
      photoUrl = _topicItemPraiseModel.user.photo;
      nickName = _topicItemPraiseModel.user.nickName;
      gmtCreate = _topicItemPraiseModel.gmtCreate;
    }
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 36.0,
              height: 36.0,
              child: ClipOval(
                  child: CircleAvatar(
                    radius: 36.0,
                    backgroundImage: CachedNetworkImageProvider(
                      GlobalConfig.imageUrlBase + photoUrl,
                    ),
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(nickName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Container(
                  child: Text(gmtCreate,
                    style: TextStyle(
                        color: Color(0xFFB4B4B4),
                        fontWeight: FontWeight.w300
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  
}