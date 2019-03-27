class Convert {

  static List<T> convertList<T>(Function target, List<dynamic> dataList) {
    if (null == dataList) {
      return null;
    }
    List<T> newList = List<T>();
    for(dynamic item in dataList) {
      newList.add(target(item));
    }
    return newList;
  }

  static List<String> convertStringList(List<dynamic> dataList) {
    if (null == dataList) {
      return null;
    }
    List<String> newList = List();
    for(dynamic item in dataList) {
      newList.add(item.toString());
    }
    return newList;
  }

  static T convertObj<T>(Function target, dynamic data) {
    if (null == data) {
      return null;
    }
    return target(data);
  }

}