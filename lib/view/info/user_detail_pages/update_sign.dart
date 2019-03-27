import 'package:flutter/material.dart';

class UpdateSignPage extends StatefulWidget {

  String _sign;

  UpdateSignPage(this._sign);

  @override
  State<StatefulWidget> createState() => _UpdateSignState();
}

class _UpdateSignState extends State<UpdateSignPage> {

  BuildContext _context;
  TextEditingController _signInputController;
  
  Widget initSaveBtn() {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10.0),
        width: 80.0,
        child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            color: Color(0xFFEDF7FF),
            onPressed: () {
              Navigator.of(context).pop(_signInputController.text);
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
              Navigator.of(context).pop(widget._sign);
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
      title: Text('签名',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.ideographic
        ),
      ),
    );
  }

  Widget initSignInput() {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: TextField(
          controller: _signInputController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.none,
          decoration: InputDecoration.collapsed(hintText: '点击输入签名...')
      ),
    );
  }

  void _initData() async {

  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _signInputController = TextEditingController(text: widget._sign);
    return Scaffold(
      appBar: initAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            initSignInput(),
          ],
        ),
      ),
    );
  }
}
