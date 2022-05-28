/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"vendor":{"id":"7","mobile":"66767678","logo":"86cea626d9d5afed51983173348e03a5.jpeg","header":"4d3cc92bd2f21990ed92a9f7f3fc66da.jpeg","enShop":"Logaimat Kuwait","arShop":"لقيمات","enDetails":"Kuwait traditional deserts  ","arDetails":"حلويات كويتية","delivery":"1 Day","time":"3600","is_busy":"0","is_new":"1","addressLine":"","startDate":"2021-10-22","times":["12:00 - 14:00","14:00 - 16:00","17:00 - 18:00pm"]},"categories":[{"id":"10","vendorId":"7","arTitle":"الاطباق الرئيسية","enTitle":"Main course ","items":[{"id":"12","categoryId":"10","arTitle":"لقيمات","enTitle":"Logaimat","arDetails":"حلويات كويتية","enDetails":"Kuwait traditional deserts  ","quantity":"-4","price":"4","discount":"0","video":"","finalPrice":"0","images":["fdfd670335af45fac7554ae3add8bc34.jpeg"]}]}]}

class VendorModel {
  VendorModel({
      bool ok, 
      String error, 
      String status, 
      Data data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  VendorModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ok'] = _ok;
    map['error'] = _error;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// vendor : {"id":"7","mobile":"66767678","logo":"86cea626d9d5afed51983173348e03a5.jpeg","header":"4d3cc92bd2f21990ed92a9f7f3fc66da.jpeg","enShop":"Logaimat Kuwait","arShop":"لقيمات","enDetails":"Kuwait traditional deserts  ","arDetails":"حلويات كويتية","delivery":"1 Day","time":"3600","is_busy":"0","is_new":"1","addressLine":"","startDate":"2021-10-22","times":["12:00 - 14:00","14:00 - 16:00","17:00 - 18:00pm"]}
/// categories : [{"id":"10","vendorId":"7","arTitle":"الاطباق الرئيسية","enTitle":"Main course ","items":[{"id":"12","categoryId":"10","arTitle":"لقيمات","enTitle":"Logaimat","arDetails":"حلويات كويتية","enDetails":"Kuwait traditional deserts  ","quantity":"-4","price":"4","discount":"0","video":"","finalPrice":"0","images":["fdfd670335af45fac7554ae3add8bc34.jpeg"]}]}]

class Data {
  Data({
      Vendor vendor, 
      List<Categories> categories,}){
    _vendor = vendor;
    _categories = categories;
}

  Data.fromJson(dynamic json) {
    _vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories.add(Categories.fromJson(v));
      });
    }
  }
  Vendor _vendor;
  List<Categories> _categories;

  Vendor get vendor => _vendor;
  List<Categories> get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_vendor != null) {
      map['vendor'] = _vendor.toJson();
    }
    if (_categories != null) {
      map['categories'] = _categories.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "10"
/// vendorId : "7"
/// arTitle : "الاطباق الرئيسية"
/// enTitle : "Main course "
/// items : [{"id":"12","categoryId":"10","arTitle":"لقيمات","enTitle":"Logaimat","arDetails":"حلويات كويتية","enDetails":"Kuwait traditional deserts  ","quantity":"-4","price":"4","discount":"0","video":"","finalPrice":"0","images":["fdfd670335af45fac7554ae3add8bc34.jpeg"]}]

class Categories {
  Categories({

      String id, 
      String vendorId, 
      String arTitle, 
      String enTitle,
    bool isExpanded,
      List<Items> items,}){
    _id = id;
    isExpanded = _isExpanded;

    _vendorId = vendorId;
    _arTitle = arTitle;
    _enTitle = enTitle;
    _items = items;
}

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _isExpanded= false;
    _vendorId = json['vendorId'];
    _arTitle = json['arTitle'];
    _enTitle = json['enTitle'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items.add(Items.fromJson(v));
      });
    }
  }
  String _id;
  String _vendorId;
  String _arTitle;
  String _enTitle;
  bool _isExpanded;
  List<Items> _items;

  String get id => _id;
  bool get isExpanded =>_isExpanded;
  String get vendorId => _vendorId;
  String get arTitle => _arTitle;
  String get enTitle => _enTitle;
  List<Items> get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['vendorId'] = _vendorId;
    map['arTitle'] = _arTitle;
    map['enTitle'] = _enTitle;

    if (_items != null) {
      map['items'] = _items.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "12"
/// categoryId : "10"
/// arTitle : "لقيمات"
/// enTitle : "Logaimat"
/// arDetails : "حلويات كويتية"
/// enDetails : "Kuwait traditional deserts  "
/// quantity : "-4"
/// price : "4"
/// discount : "0"
/// video : ""
/// finalPrice : "0"
/// images : ["fdfd670335af45fac7554ae3add8bc34.jpeg"]

class Items {
  Items({
      String id, 
      String categoryId, 
      String arTitle, 
      String enTitle, 
      String arDetails, 
      String enDetails, 
      String quantity, 
      String price, 
      String discount, 
      String video, 
      String finalPrice, 
      List<String> images,}){
    _id = id;
    _categoryId = categoryId;
    _arTitle = arTitle;
    _enTitle = enTitle;
    _arDetails = arDetails;
    _enDetails = enDetails;
    _quantity = quantity;
    _price = price;
    _discount = discount;
    _video = video;
    _finalPrice = finalPrice;
    _images = images;
}

  Items.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['categoryId'];
    _arTitle = json['arTitle'];
    _enTitle = json['enTitle'];
    _arDetails = json['arDetails'];
    _enDetails = json['enDetails'];
    _quantity = json['quantity'];
    _price = json['price'];
    _discount = json['discount'];
    _video = json['video'];
    _finalPrice = json['finalPrice'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  String _id;
  String _categoryId;
  String _arTitle;
  String _enTitle;
  String _arDetails;
  String _enDetails;
  String _quantity;
  String _price;
  String _discount;
  String _video;
  String _finalPrice;
  List<String> _images;

  String get id => _id;
  String get categoryId => _categoryId;
  String get arTitle => _arTitle;
  String get enTitle => _enTitle;
  String get arDetails => _arDetails;
  String get enDetails => _enDetails;
  String get quantity => _quantity;
  String get price => _price;
  String get discount => _discount;
  String get video => _video;
  String get finalPrice => _finalPrice;
  List<String> get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['categoryId'] = _categoryId;
    map['arTitle'] = _arTitle;
    map['enTitle'] = _enTitle;
    map['arDetails'] = _arDetails;
    map['enDetails'] = _enDetails;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['discount'] = _discount;
    map['video'] = _video;
    map['finalPrice'] = _finalPrice;
    map['images'] = _images;
    return map;
  }

}

/// id : "7"
/// mobile : "66767678"
/// logo : "86cea626d9d5afed51983173348e03a5.jpeg"
/// header : "4d3cc92bd2f21990ed92a9f7f3fc66da.jpeg"
/// enShop : "Logaimat Kuwait"
/// arShop : "لقيمات"
/// enDetails : "Kuwait traditional deserts  "
/// arDetails : "حلويات كويتية"
/// delivery : "1 Day"
/// time : "3600"
/// is_busy : "0"
/// is_new : "1"
/// addressLine : ""
/// startDate : "2021-10-22"
/// times : ["12:00 - 14:00","14:00 - 16:00","17:00 - 18:00pm"]

class Vendor {
  Vendor({
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
      String isNew, 
      String addressLine, 
      String startDate, 
      List<String> times,}){
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
    _addressLine = addressLine;
    _startDate = startDate;
    _times = times;
}

  Vendor.fromJson(dynamic json) {
    _id = json['id'];
    _mobile = json['mobile'];
    _logo = json['logo'];
    _header = json['header'];
    _enShop = json['enShop'];
    _arShop = json['arShop'];
    _enDetails = json['enDetails'];
    _arDetails = json['arDetails'];
    _delivery = json['delivery'];
    _time = json['time'];
    _isBusy = json['is_busy'];
    _isNew = json['is_new'];
    _addressLine = json['addressLine'];
    _startDate = json['startDate'];
    _times = json['times'] != null ? json['times'].cast<String>() : [];
  }
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
  String _addressLine;
  String _startDate;
  List<String> _times;

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
  String get addressLine => _addressLine;
  String get startDate => _startDate;
  List<String> get times => _times;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mobile'] = _mobile;
    map['logo'] = _logo;
    map['header'] = _header;
    map['enShop'] = _enShop;
    map['arShop'] = _arShop;
    map['enDetails'] = _enDetails;
    map['arDetails'] = _arDetails;
    map['delivery'] = _delivery;
    map['time'] = _time;
    map['is_busy'] = _isBusy;
    map['is_new'] = _isNew;
    map['addressLine'] = _addressLine;
    map['startDate'] = _startDate;
    map['times'] = _times;
    return map;
  }

}