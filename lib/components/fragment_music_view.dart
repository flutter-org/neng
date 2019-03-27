import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neng/model/fragment.dart';

class FragmentMusicView extends StatefulWidget {

  FragmentModel _fragmentModel;

  FragmentMusicView(this._fragmentModel);

  @override
  State<StatefulWidget> createState() => _FragmentMusicView();
  
}

class _FragmentMusicView extends State<FragmentMusicView> {

  BuildContext _context;
  AudioPlayer _audioPlayer = AudioPlayer();
  String _playIcon = 'assets/message/start.png';
  bool _isPlay = false;
  double _nowPlayProgress = 0.0;
  int _playTime;

  Widget initFragmentMusic() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
      child: Column(
        children: <Widget>[
          initMusicImage(),
          initMusicPlayer(),
          initMusicPlayerProgress(),
        ],
      ),
    );
  }

  Widget initMusicImage() {
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

  Widget initMusicPlayer() {
    return Container(
        padding: EdgeInsets.only(top: 20.0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(_playIcon, width: 28.0, height: 28.0),
                ),
                onTap: _play,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Column(
                  children: <Widget>[
                    Text(widget._fragmentModel.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0
                      ),
                    ),
                    Text(widget._fragmentModel.author,
                      style: TextStyle(
                          fontSize: 14.0
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }

  Widget initMusicPlayerProgress() {
    return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: SizedBox(
          height: 2.0,
          child: LinearProgressIndicator(
            value: _nowPlayProgress,
            backgroundColor: Colors.black,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        )
    );
  }

  void _play() {
    if (_isPlay) {
      _isPlay = false;
      _playIcon = 'assets/message/start.png';
      _stopAction();
    } else {
      _isPlay = true;
      _playIcon = 'assets/message/stop.png';
      _startAction();
    }
    setState(() {});
  }

  void _startAction() {
    _audioPlayer.play(widget._fragmentModel.music);
  }

  void _stopAction() {
    _audioPlayer.stop();
  }

  void _initPlayListen() {
    _audioPlayer.onDurationChanged.listen((Duration d) => setState(() {
      _playTime = d.inSeconds;
    }));
    _audioPlayer.onAudioPositionChanged.listen((Duration d) => setState(() {
      if (null == _playTime) {
        return;
      }

      double playProgress = d.inSeconds / _playTime;
      if (playProgress == _nowPlayProgress) {
        return;
      }

      _nowPlayProgress = playProgress;
    }));
  }

  @override
  void dispose() {
    super.dispose();
    _stopAction();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _initPlayListen();
    return initFragmentMusic();
  }
}