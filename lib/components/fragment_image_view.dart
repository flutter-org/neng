import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neng/model/fragment.dart';

class FragmentImageView extends StatefulWidget {

  FragmentModel _fragmentModel;

  FragmentImageView(this._fragmentModel);

  @override
  State<StatefulWidget> createState() => _FragmentImageView();
  
}

class _FragmentImageView extends State<FragmentImageView> {

  BuildContext _context;

  Widget initFragmentImage() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
      child: Column(
        children: <Widget>[
          initImage(),

        ],
      ),
    );
  }

  Widget initImage() {
    return Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: widget._fragmentModel.image,
              fit: BoxFit.fill,
              height: 380.0,
            )
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
    return initFragmentImage();
  }
}