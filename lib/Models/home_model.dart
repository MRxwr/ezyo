/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"tags":[{"id":"1","arTitle":"البرجر","enTitle":"Burgers","logo":"8929c543b610ec9ff59d92b9f05d64ef.png"},{"id":"2","arTitle":"البيتزا","enTitle":"Pizza","logo":"fbd41adff0d40251e5cf4b770145108b.png"}],"banners":[{"id":"1","enTitle":"banner 2","arTitle":"البنر الأول ","image":"c525f488c00b62903f5d57b8d90f6a27.png","url":"http://www.google.com"}],"vendors":[{"id":"1","mobile":"+96590949089","logo":"21c2e597c4c7dfebc9a30148ab4d6697.png","header":"","enShop":"MARKA","arShop":"ماركة","enDetails":"Details ","arDetails":"تفاصيل","delivery":"30 min","is_busy":"0","is_new":"0"},{"id":"3","mobile":"+96590949089","logo":"0a5cfdfdd0da70b39082e0c7b358be7a.png","header":"350eed011d472826b842789b323ab691.png","enShop":"CREATE ME NOW","arShop":"نحن هنا الآن","enDetails":" Shop Details English ","arDetails":"تفاصيل","delivery":"20","is_busy":"0","is_new":"0"}]}

class HomeModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  HomeModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  HomeModel.fromJson(dynamic json) {
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

/// tags : [{"id":"1","arTitle":"البرجر","enTitle":"Burgers","logo":"8929c543b610ec9ff59d92b9f05d64ef.png"},{"id":"2","arTitle":"البيتزا","enTitle":"Pizza","logo":"fbd41adff0d40251e5cf4b770145108b.png"}]
/// banners : [{"id":"1","enTitle":"banner 2","arTitle":"البنر الأول ","image":"c525f488c00b62903f5d57b8d90f6a27.png","url":"http://www.google.com"}]
/// vendors : [{"id":"1","mobile":"+96590949089","logo":"21c2e597c4c7dfebc9a30148ab4d6697.png","header":"","enShop":"MARKA","arShop":"ماركة","enDetails":"Details ","arDetails":"تفاصيل","delivery":"30 min","is_busy":"0","is_new":"0"},{"id":"3","mobile":"+96590949089","logo":"0a5cfdfdd0da70b39082e0c7b358be7a.png","header":"350eed011d472826b842789b323ab691.png","enShop":"CREATE ME NOW","arShop":"نحن هنا الآن","enDetails":" Shop Details English ","arDetails":"تفاصيل","delivery":"20","is_busy":"0","is_new":"0"}]

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

/// id : "1"
/// mobile : "+96590949089"
/// logo : "21c2e597c4c7dfebc9a30148ab4d6697.png"
/// header : ""
/// enShop : "MARKA"
/// arShop : "ماركة"
/// enDetails : "Details "
/// arDetails : "تفاصيل"
/// delivery : "30 min"
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
    map["is_busy"] = _isBusy;
    map["is_new"] = _isNew;
    return map;
  }

}

/// id : "1"
/// enTitle : "banner 2"
/// arTitle : "البنر الأول "
/// image : "c525f488c00b62903f5d57b8d90f6a27.png"
/// url : "http://www.google.com"

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
/// arTitle : "البرجر"
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
      String logo,
}){

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