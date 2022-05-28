/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"orderId":"918277","date":"2021-08-01 03:19:09","payment":"K-net","delivery":"2","service":"0.5","price":"9","status":"","note":"321","customer":{"name":"nasser hatb"},"address":{"name":"Adan Home","country":"Kwuait","area":"Adan","block":"4","street":"10","house":"51","avenue":"","floor":"","flat":"","mobile":"+96590949089"},"vendor":{"enTitle":"MARKA","arTitle":"ماركة","logo":"21c2e597c4c7dfebc9a30148ab4d6697.png"},"voucher":{"code":"NASER20","discount":"20"},"items":[{"arTitle":"منتج","enTitle":"product 1","quantity":"1","discount":"10","price":"9","note":"fsdf ","logo":"f74d5d4b99e7ff83659843a2f83bf04f.png"}]}

class OrderDetailsModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  OrderDetailsModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  OrderDetailsModel.fromJson(dynamic json) {
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

/// orderId : "918277"
/// date : "2021-08-01 03:19:09"
/// payment : "K-net"
/// delivery : "2"
/// service : "0.5"
/// price : "9"
/// status : ""
/// note : "321"
/// customer : {"name":"nasser hatb"}
/// address : {"name":"Adan Home","country":"Kwuait","area":"Adan","block":"4","street":"10","house":"51","avenue":"","floor":"","flat":"","mobile":"+96590949089"}
/// vendor : {"enTitle":"MARKA","arTitle":"ماركة","logo":"21c2e597c4c7dfebc9a30148ab4d6697.png"}
/// voucher : {"code":"NASER20","discount":"20"}
/// items : [{"arTitle":"منتج","enTitle":"product 1","quantity":"1","discount":"10","price":"9","note":"fsdf ","logo":"f74d5d4b99e7ff83659843a2f83bf04f.png"}]

class Data {
  String _orderId;
  String _date;
  String _payment;
  String _delivery;
  String _service;
  String _price;
  String _status;
  String _note;
  Customer _customer;
  Address _address;
  Vendor _vendor;
  Voucher _voucher;
  List<Items> _items;

  String get orderId => _orderId;
  String get date => _date;
  String get payment => _payment;
  String get delivery => _delivery;
  String get service => _service;
  String get price => _price;
  String get status => _status;
  String get note => _note;
  Customer get customer => _customer;
  Address get address => _address;
  Vendor get vendor => _vendor;
  Voucher get voucher => _voucher;
  List<Items> get items => _items;

  Data({
      String orderId, 
      String date, 
      String payment, 
      String delivery, 
      String service, 
      String price, 
      String status, 
      String note, 
      Customer customer, 
      Address address, 
      Vendor vendor, 
      Voucher voucher, 
      List<Items> items}){
    _orderId = orderId;
    _date = date;
    _payment = payment;
    _delivery = delivery;
    _service = service;
    _price = price;
    _status = status;
    _note = note;
    _customer = customer;
    _address = address;
    _vendor = vendor;
    _voucher = voucher;
    _items = items;
}

  Data.fromJson(dynamic json) {
    _orderId = json["orderId"];
    _date = json["date"];
    _payment = json["payment"];
    _delivery = json["delivery"];
    _service = json["service"];
    _price = json["price"];
    _status = json["status"];
    _note = json["note"];
    _customer = json["customer"] != null ? Customer.fromJson(json["customer"]) : null;
    _address = json["address"] != null ? Address.fromJson(json["address"]) : null;
    _vendor = json["vendor"] != null ? Vendor.fromJson(json["vendor"]) : null;
    _voucher = json["voucher"] != null ? Voucher.fromJson(json["voucher"]) : null;
    if (json["items"] != null) {
      _items = [];
      json["items"].forEach((v) {
        _items.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["orderId"] = _orderId;
    map["date"] = _date;
    map["payment"] = _payment;
    map["delivery"] = _delivery;
    map["service"] = _service;
    map["price"] = _price;
    map["status"] = _status;
    map["note"] = _note;
    if (_customer != null) {
      map["customer"] = _customer.toJson();
    }
    if (_address != null) {
      map["address"] = _address.toJson();
    }
    if (_vendor != null) {
      map["vendor"] = _vendor.toJson();
    }
    if (_voucher != null) {
      map["voucher"] = _voucher.toJson();
    }
    if (_items != null) {
      map["items"] = _items.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// arTitle : "منتج"
/// enTitle : "product 1"
/// quantity : "1"
/// discount : "10"
/// price : "9"
/// note : "fsdf "
/// logo : "f74d5d4b99e7ff83659843a2f83bf04f.png"

class Items {
  String _arTitle;
  String _enTitle;
  String _quantity;
  String _discount;
  String _price;
  String _note;
  String _logo;

  String get arTitle => _arTitle;
  String get enTitle => _enTitle;
  String get quantity => _quantity;
  String get discount => _discount;
  String get price => _price;
  String get note => _note;
  String get logo => _logo;

  Items({
      String arTitle, 
      String enTitle, 
      String quantity, 
      String discount, 
      String price, 
      String note, 
      String logo}){
    _arTitle = arTitle;
    _enTitle = enTitle;
    _quantity = quantity;
    _discount = discount;
    _price = price;
    _note = note;
    _logo = logo;
}

  Items.fromJson(dynamic json) {
    _arTitle = json["arTitle"];
    _enTitle = json["enTitle"];
    _quantity = json["quantity"];
    _discount = json["discount"];
    _price = json["price"];
    _note = json["note"];
    _logo = json["logo"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["arTitle"] = _arTitle;
    map["enTitle"] = _enTitle;
    map["quantity"] = _quantity;
    map["discount"] = _discount;
    map["price"] = _price;
    map["note"] = _note;
    map["logo"] = _logo;
    return map;
  }

}

/// code : "NASER20"
/// discount : "20"

class Voucher {
  String _code;
  String _discount;

  String get code => _code;
  String get discount => _discount;

  Voucher({
      String code, 
      String discount}){
    _code = code;
    _discount = discount;
}

  Voucher.fromJson(dynamic json) {
    _code = json["code"];
    _discount = json["discount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["discount"] = _discount;
    return map;
  }

}

/// enTitle : "MARKA"
/// arTitle : "ماركة"
/// logo : "21c2e597c4c7dfebc9a30148ab4d6697.png"

class Vendor {
  String _enTitle;
  String _arTitle;
  String _logo;

  String get enTitle => _enTitle;
  String get arTitle => _arTitle;
  String get logo => _logo;

  Vendor({
      String enTitle, 
      String arTitle, 
      String logo}){
    _enTitle = enTitle;
    _arTitle = arTitle;
    _logo = logo;
}

  Vendor.fromJson(dynamic json) {
    _enTitle = json["enTitle"];
    _arTitle = json["arTitle"];
    _logo = json["logo"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["enTitle"] = _enTitle;
    map["arTitle"] = _arTitle;
    map["logo"] = _logo;
    return map;
  }

}

/// name : "Adan Home"
/// country : "Kwuait"
/// area : "Adan"
/// block : "4"
/// street : "10"
/// house : "51"
/// avenue : ""
/// floor : ""
/// flat : ""
/// mobile : "+96590949089"

class Address {
  String _name;
  String _country;
  String _area;
  String _block;
  String _street;
  String _house;
  String _avenue;
  String _floor;
  String _flat;
  String _mobile;

  String get name => _name;
  String get country => _country;
  String get area => _area;
  String get block => _block;
  String get street => _street;
  String get house => _house;
  String get avenue => _avenue;
  String get floor => _floor;
  String get flat => _flat;
  String get mobile => _mobile;

  Address({
      String name, 
      String country, 
      String area, 
      String block, 
      String street, 
      String house, 
      String avenue, 
      String floor, 
      String flat, 
      String mobile}){
    _name = name;
    _country = country;
    _area = area;
    _block = block;
    _street = street;
    _house = house;
    _avenue = avenue;
    _floor = floor;
    _flat = flat;
    _mobile = mobile;
}

  Address.fromJson(dynamic json) {
    _name = json["name"];
    _country = json["country"];
    _area = json["area"];
    _block = json["block"];
    _street = json["street"];
    _house = json["house"];
    _avenue = json["avenue"];
    _floor = json["floor"];
    _flat = json["flat"];
    _mobile = json["mobile"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["country"] = _country;
    map["area"] = _area;
    map["block"] = _block;
    map["street"] = _street;
    map["house"] = _house;
    map["avenue"] = _avenue;
    map["floor"] = _floor;
    map["flat"] = _flat;
    map["mobile"] = _mobile;
    return map;
  }

}

/// name : "nasser hatb"

class Customer {
  String _name;

  String get name => _name;

  Customer({
      String name}){
    _name = name;
}

  Customer.fromJson(dynamic json) {
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    return map;
  }

}