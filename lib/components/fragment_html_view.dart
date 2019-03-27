import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:neng/model/fragment.dart';

class FragmentHtmlView extends StatefulWidget {

  FragmentModel _fragmentModel;

  FragmentHtmlView(this._fragmentModel);

  @override
  State<StatefulWidget> createState() => _FragmentHtmlView();
  
}

class _FragmentHtmlView extends State<FragmentHtmlView> {

  BuildContext _context;

  Widget initFragmentHtml() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
      child: Column(
        children: <Widget>[
          intiTitle(),
          initAuthor(),
          initImage(),
          initHtml(),
        ],
      ),
    );
  }

  Widget intiTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(widget._fragmentModel.title,
        style: TextStyle(
          fontSize: 28
        ),
      ),
    );
  }

  Widget initAuthor() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
      alignment: Alignment.centerLeft,
      child: Text(widget._fragmentModel.author),
    );
  }

  Widget initImage() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: widget._fragmentModel.image,
          fit: BoxFit.fill,
        )
      )
    );
  }

  Widget initHtml() {
    return Container(
      child: Html(
        data: widget._fragmentModel.content,
        //Optional parameters:
        padding: EdgeInsets.all(8.0),
        backgroundColor: Colors.white,
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return SingleChildScrollView(
      child: initFragmentHtml(),
    );
  }
}