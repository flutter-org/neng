import 'package:flutter/material.dart';

class BottomSheetView {

  Widget _bottomSheetLine() {
    return Container(
      margin: EdgeInsets.only(bottom: 0.8),
    );
  }

  void showBottomSheet(BuildContext _context, Map<String, Function> data) {
    double height = 110.0;
    List<Widget> dataViewList = List();
    for (String key in data.keys) {
      dataViewList.add(
          Container(
            height: 60.0,
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            color: Colors.white,
            child: GestureDetector(
              child: Center(
                child: Text(key,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: data[key],
            ),
          )
      );
      dataViewList.add(_bottomSheetLine());
      height += 60.8;
    }
    dataViewList.add(
        Container(
          height: 110.0,
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: GestureDetector(
              child: Center(
                child: Text('取消',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
          ),
        )
    );

    showModalBottomSheet(
        context: _context,
        builder: (BuildContext context) {
          return Container(
              height: height,
              color: Color(0xFFF0F0F0),
              child: Column(
                  children: dataViewList
              )
          );
        }
    );
  }

}