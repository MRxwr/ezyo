/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"tags":[{"id":"1","arTitle":"برجر","enTitle":"Burgers","logo":"8929c543b610ec9ff59d92b9f05d64ef.png"},{"id":"2","arTitle":"بيتزا","enTitle":"Pizza","logo":"fbd41adff0d40251e5cf4b770145108b.png"},{"id":"3","arTitle":"باستا","enTitle":"Pasta","logo":""},{"id":"4","arTitle":"سلطة","enTitle":"Salad","logo":""},{"id":"5","arTitle":"بحري","enTitle":"Seafood","logo":""},{"id":"6","arTitle":"عيوش","enTitle":"Rice","logo":""},{"id":"7","arTitle":"حساء","enTitle":"Soup","logo":""},{"id":"8","arTitle":"حلويات","enTitle":"Sweet","logo":""},{"id":"9","arTitle":"مشروبات","enTitle":"Drinks","logo":""},{"id":"11","arTitle":"فطور","enTitle":"Breakfast","logo":""},{"id":"12","arTitle":"كويتي","enTitle":"Kuwaiti","logo":""},{"id":"13","arTitle":"هندي","enTitle":"Indian","logo":""},{"id":"14","arTitle":"ايطالي","enTitle":"Italian","logo":""},{"id":"15","arTitle":"مكسيكي","enTitle":"Mexican","logo":""},{"id":"16","arTitle":"أمريكي","enTitle":"American","logo":""}],"banners":[{"id":"2","enTitle":"Fast food","arTitle":"مطاعم سريعة","image":"b2db0d0b047cc73f875770934cde447a.jpg","url":"https://www.google.com/search?q=food+banner&oq=food+banner+&aqs=chrome..69i57j0i512l4.5510j0j9&client=ms-android-huawei-rev1&sourceid=chrome-mobile&ie=UTF-8#imgrc=vbWyP0upBc5A7M"},{"id":"3","enTitle":"EZYO","arTitle":"ايزي او","image":"025c4c95addf7e550bbfcd7d206edf24.jpg","url":"https://instagram.com/ezyo_kw?utm_medium=copy_link"}],"vendors":[{"id":"8","mobile":"99999999","logo":"cb2268a2313f6b5f92af4f45495e6cd7.jpeg","header":"bd2704c90ef9af9e97f777594bb0800f.jpeg","enShop":"Waraq anab","arShop":"ورق عنب ","enDetails":"Sweet and Sour Food ","arDetails":"ورق عنب حامض حلو ","delivery":"1 hr ","time":"60","is_busy":"0","is_new":"0"}]}

class SearchModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  SearchModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  SearchModel.fromJson(dynamic json) {
    _ok = json["ok"];
    _error = json["error"];
    _status = json["status"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ok"] = _ok;
    map["error"] = _error;
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// tags : [{"id":"1","arTitle":"برجر","enTitle":"Burgers","logo":"8929c543b610ec9ff59d92b9f05d64ef.png"},{"id":"2","arTitle":"بيتزا","enTitle":"Pizza","logo":"fbd41adff0d40251e5cf4b770145108b.png"},{"id":"3","arTitle":"باستا","enTitle":"Pasta","logo":""},{"id":"4","arTitle":"سلطة","enTitle":"Salad","logo":""},{"id":"5","arTitle":"بحري","enTitle":"Seafood","logo":""},{"id":"6","arTitle":"عيوش","enTitle":"Rice","logo":""},{"id":"7","arTitle":"حساء","enTitle":"Soup","logo":""},{"id":"8","arTitle":"حلويات","enTitle":"Sweet","logo":""},{"id":"9","arTitle":"مشروبات","enTitle":"Drinks","logo":""},{"id":"11","arTitle":"فطور","enTitle":"Breakfast","logo":""},{"id":"12","arTitle":"كويتي","enTitle":"Kuwaiti","logo":""},{"id":"13","arTitle":"هندي","enTitle":"Indian","logo":""},{"id":"14","arTitle":"ايطالي","enTitle":"Italian","logo":""},{"id":"15","arTitle":"مكسيكي","enTitle":"Mexican","logo":""},{"id":"16","arTitle":"أمريكي","enTitle":"American","logo":""}]
/// banners : [{"id":"2","enTitle":"Fast food","arTitle":"مطاعم سريعة","image":"b2db0d0b047cc73f875770934cde447a.jpg","url":"https://www.google.com/search?q=food+banner&oq=food+banner+&aqs=chrome..69i57j0i512l4.5510j0j9&client=ms-android-huawei-rev1&sourceid=chrome-mobile&ie=UTF-8#imgrc=vbWyP0upBc5A7M"},{"id":"3","enTitle":"EZYO","arTitle":"ايزي او","image":"025c4c95addf7e550bbfcd7d206edf24.jpg","url":"https://instagram.com/ezyo_kw?utm_medium=copy_link"}]
/// vendors : [{"id":"8","mobile":"99999999","logo":"cb2268a2313f6b5f92af4f45495e6cd7.jpeg","header":"bd2704c90ef9af9e97f777594bb0800f.jpeg","enShop":"Waraq anab","arShop":"ورق عنب ","enDetails":"Sweet and Sour Food ","arDetails":"ورق عنب حامض حلو ","delivery":"1 hr ","time":"60","is_busy":"0","is_new":"0"}]

class Data {
  List<Tags> _tags;
  List<Banners> _banners;
  List<Vendors> _vendors;

  List<Tags> get tags => _tags;
  List<Banners> get banners => _banners;
  List<Vendors> get vendors => _vendors;

  Data({
      List<Tags> tags, 
      List<Banners> banners, 
      List<Vendors> vendors}){
    _tags = tags;
    _banners = banners;
    _vendors = vendors;
}

  Data.fromJson(dynamic json) {
    if (json["tags"] != null) {
      _tags = [];
      json["tags"].forEach((v) {
        _tags.add(Tags.fromJson(v));
      });
    }
    if (json["banners"] != null) {
      _banners = [];
      json["banners"].forEach((v) {
        _banners.add(Banners.fromJson(v));
      });
    }
    if (json["vendors"] != null) {
      _vendors = [];
      json["vendors"].forEach((v) {
        _vendors.add(Vendors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_tags != null) {
      map["tags"] = _tags.map((v) => v.toJson()).toList();
    }
    if (_banners != null) {
      map["banners"] = _banners.map((v) => v.toJson()).toList();
    }
    if (_vendors != null) {
      map["vendors"] = _vendors.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "8"
/// mobile : "99999999"
/// logo : "cb2268a2313f6b5f92af4f45495e6cd7.jpeg"
/// header : "bd2704c90ef9af9e97f777594bb0800f.jpeg"
/// enShop : "Waraq anab"
/// arShop : "ورق عنب "
/// enDetails : "Sweet and Sour Food "
/// arDetails : "ورق عنب حامض حلو "
/// delivery : "1 hr "
/// time : "60"
/// is_busy : "0"
/// is_new : "0"

class Vendors {
  String _id;
  String _mobile;
  String _logo;
  String _header;
  String _enShop;
  String _arShop;
  String _enDetails;
  String _arDetails;
  String _delivery;
  String _time;
  String _isBusy;
  String _isNew;

  String get id => _id;
  String get mobile => _mobile;
  String get logo => _logo;
  String get header => _header;
  String get enShop => _enShop;
  String get arShop => _arShop;
  String get enDetails => _enDetails;
  String get arDetails => _arDetails;
  String get delivery => _delivery;
  String get time => _time;
  String get isBusy => _isBusy;
  String get isNew => _isNew;

  Vendors({
      String id, 
      String mobile, 
      String logo, 
      String header, 
      String enShop, 
      String arShop, 
      String enDetails, 
      String arDetails, 
      String delivery, 
      String time, 
      String isBusy, 
      String isNew}){
    _id = id;
    _mobile = mobile;
    _logo = logo;
    _header = header;
    _enShop = enShop;
    _arShop = arShop;
    _enDetails = enDetails;
    _arDetails = arDetails;
    _delivery = delivery;
    _time = time;
    _isBusy = isBusy;
    _isNew = isNew;
}

  Vendors.fromJson(dynamic json) {
    _id = json["id"];
    _mobile = json["mobile"];
    _logo = json["logo"];
    _header = json["header"];
    _enShop = json["enShop"];
    _arShop = json["arShop"];
    _enDetails = json["enDetails"];
    _arDetails = json["arDetails"];
    _delivery = json["delivery"];
    _time = json["time"];
    _isBusy = json["is_busy"];
    _isNew = json["is_new"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["mobile"] = _mobile;
    map["logo"] = _logo;
    map["header"] = _header;
    map["enShop"] = _enShop;
    map["arShop"] = _arShop;
    map["enDetails"] = _enDetails;
    map["arDetails"] = _arDetails;
    map["delivery"] = _delivery;
    map["time"] = _time;
    map["is_busy"] = _isBusy;
    map["is_new"] = _isNew;
    return map;
  }

}

/// id : "2"
/// enTitle : "Fast food"
/// arTitle : "مطاعم سريعة"
/// image : "b2db0d0b047cc73f875770934cde447a.jpg"
/// url : "https://www.google.com/search?q=food+banner&oq=food+banner+&aqs=chrome..69i57j0i512l4.5510j0j9&client=ms-android-huawei-rev1&sourceid=chrome-mobile&ie=UTF-8#imgrc=vbWyP0upBc5A7M"

class Banners {
  String _id;
  String _enTitle;
  String _arTitle;
  String _image;
  String _url;

  String get id => _id;
  String get enTitle => _enTitle;
  String get arTitle => _arTitle;
  String get image => _image;
  String get url => _url;

  Banners({
      String id, 
      String enTitle, 
      String arTitle, 
      String image, 
      String url}){
    _id = id;
    _enTitle = enTitle;
    _arTitle = arTitle;
    _image = image;
    _url = url;
}

  Banners.fromJson(dynamic json) {
    _id = json["id"];
    _enTitle = json["enTitle"];
    _arTitle = json["arTitle"];
    _image = json["image"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["enTitle"] = _enTitle;
    map["arTitle"] = _arTitle;
    map["image"] = _image;
    map["url"] = _url;
    return map;
  }

}

/// id : "1"
/// arTitle : "برجر"
/// enTitle : "Burgers"
/// logo : "8929c543b610ec9ff59d92b9f05d64ef.png"

class Tags {
  String _id;
  String _arTitle;
  String _enTitle;
  String _logo;

  String get id => _id;
  String get arTitle => _arTitle;
  String get enTitle => _enTitle;
  String get logo => _logo;

  Tags({
      String id, 
      String arTitle, 
      String enTitle, 
      String logo}){
    _id = id;
    _arTitle = arTitle;
    _enTitle = enTitle;
    _logo = logo;
}

  Tags.fromJson(dynamic json) {
    _id = json["id"];
    _arTitle = json["arTitle"];
    _enTitle = json["enTitle"];
    _logo = json["logo"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["arTitle"] = _arTitle;
    map["enTitle"] = _enTitle;
    map["logo"] = _logo;
    return map;
  }

}