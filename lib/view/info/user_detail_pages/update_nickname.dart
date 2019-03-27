import 'package:flutter/material.dart';

class UpdateNicknamePage extends StatefulWidget {

  String _nickname;

  UpdateNicknamePage(this._nickname);

  @override
  State<StatefulWidget> createState() => _UpdateNicknameState();
}

class _UpdateNicknameState extends State<UpdateNicknamePage> {

  BuildContext _context;
  TextEditingController _nicknameInputController;
  
  Widget initSaveBtn() {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10.0),
        width: 80.0,
        child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            color: Color(0xFFEDF7FF),
            onPressed: () {
              Navigator.of(context).pop(_nicknameInputController.text);
            },
            child: Text('保存',
              style: TextStyle(
                  color: Colors.black
              ),
            )
        )
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
              FocusScope.of(_context).requestFocus(FocusNode());
              Navigator.of(context).pop(widget._nickname);
            },
          );
        },
      ),
      actions: <Widget>[
        initSaveBtn()
      ],
      elevation: 0.0,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Text('昵称',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.ideographic
        ),
      ),
    );
  }

  Widget initNicknameInput() {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: TextField(
          controller: _nicknameInputController,
          maxLines: 1,
          textInputAction: TextInputAction.none,
          decoration: InputDecoration.collapsed(hintText: '点击输入昵称...')
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _nicknameInputController = TextEditingController(text: widget._nickname);
    return Scaffold(
      appBar: initAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            initNicknameInput(),
          ],
        ),
      ),
    );
  }
}
