/// ok : false
/// error : "1"
/// status : "Error"
/// data : [{"id":"1","date":"2021-07-25 17:49:24","orderId":"123132","customerId":"1","addressId":"1","vendorId":"3","itemId":"1","quantity":"1","itemDiscount":"15","itemPrice":"10","itemNote":"am item","voucherId":"0","voucherDiscount":"0","price":"17.5","mobile":"+96590949089","orderNote":"dont ring bill","paymentMethod":"0","delivery":"1.5","service":"0","status":"1"},{"id":"3","date":"2021-07-25 17:49:24","orderId":"123132","customerId":"1","addressId":"1","vendorId":"1","itemId":"1","quantity":"1","itemDiscount":"10","itemPrice":"10","itemNote":"am item","voucherId":"0","voucherDiscount":"0","price":"17.5","mobile":"+96590949089","orderNote":"dont ring bill","paymentMethod":"0","delivery":"1.5","service":"0","status":"5"}]

class SuccessPaymentModel {
  bool _ok;
  String _error;
  String _status;
  List<Data> _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  List<Data> get data => _data;

  SuccessPaymentModel({
      bool ok, 
      String error, 
      String status, 
      List<Data> data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  SuccessPaymentModel.fromJson(dynamic json) {
    _ok = json["ok"];
    _error = json["error"];
    _status = json["status"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ok"] = _ok;
    map["error"] = _error;
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// date : "2021-07-25 17:49:24"
/// orderId : "123132"
/// customerId : "1"
/// addressId : "1"
/// vendorId : "3"
/// itemId : "1"
/// quantity : "1"
/// itemDiscount : "15"
/// itemPrice : "10"
/// itemNote : "am item"
/// voucherId : "0"
/// voucherDiscount : "0"
/// price : "17.5"
/// mobile : "+96590949089"
/// orderNote : "dont ring bill"
/// paymentMethod : "0"
/// delivery : "1.5"
/// service : "0"
/// status : "1"

class Data {
  String _id;
  String _date;
  String _orderId;
  String _customerId;
  String _addressId;
  String _vendorId;
  String _itemId;
  String _quantity;
  String _itemDiscount;
  String _itemPrice;
  String _itemNote;
  String _voucherId;
  String _voucherDiscount;
  String _price;
  String _mobile;
  String _orderNote;
  String _paymentMethod;
  String _delivery;
  String _service;
  String _status;

  String get id => _id;
  String get date => _date;
  String get orderId => _orderId;
  String get customerId => _customerId;
  String get addressId => _addressId;
  String get vendorId => _vendorId;
  String get itemId => _itemId;
  String get quantity => _quantity;
  String get itemDiscount => _itemDiscount;
  String get itemPrice => _itemPrice;
  String get itemNote => _itemNote;
  String get voucherId => _voucherId;
  String get voucherDiscount => _voucherDiscount;
  String get price => _price;
  String get mobile => _mobile;
  String get orderNote => _orderNote;
  String get paymentMethod => _paymentMethod;
  String get delivery => _delivery;
  String get service => _service;
  String get status => _status;

  Data({
      String id, 
      String date, 
      String orderId, 
      String customerId, 
      String addressId, 
      String vendorId, 
      String itemId, 
      String quantity, 
      String itemDiscount, 
      String itemPrice, 
      String itemNote, 
      String voucherId, 
      String voucherDiscount, 
      String price, 
      String mobile, 
      String orderNote, 
      String paymentMethod, 
      String delivery, 
      String service, 
      String status}){
    _id = id;
    _date = date;
    _orderId = orderId;
    _customerId = customerId;
    _addressId = addressId;
    _vendorId = vendorId;
    _itemId = itemId;
    _quantity = quantity;
    _itemDiscount = itemDiscount;
    _itemPrice = itemPrice;
    _itemNote = itemNote;
    _voucherId = voucherId;
    _voucherDiscount = voucherDiscount;
    _price = price;
    _mobile = mobile;
    _orderNote = orderNote;
    _paymentMethod = paymentMethod;
    _delivery = delivery;
    _service = service;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _date = json["date"];
    _orderId = json["orderId"];
    _customerId = json["customerId"];
    _addressId = json["addressId"];
    _vendorId = json["vendorId"];
    _itemId = json["itemId"];
    _quantity = json["quantity"];
    _itemDiscount = json["itemDiscount"];
    _itemPrice = json["itemPrice"];
    _itemNote = json["itemNote"];
    _voucherId = json["voucherId"];
    _voucherDiscount = json["voucherDiscount"];
    _price = json["price"];
    _mobile = json["mobile"];
    _orderNote = json["orderNote"];
    _paymentMethod = json["paymentMethod"];
    _delivery = json["delivery"];
    _service = json["service"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["date"] = _date;
    map["orderId"] = _orderId;
    map["customerId"] = _customerId;
    map["addressId"] = _addressId;
    map["vendorId"] = _vendorId;
    map["itemId"] = _itemId;
    map["quantity"] = _quantity;
    map["itemDiscount"] = _itemDiscount;
    map["itemPrice"] = _itemPrice;
    map["itemNote"] = _itemNote;
    map["voucherId"] = _voucherId;
    map["voucherDiscount"] = _voucherDiscount;
    map["price"] = _price;
    map["mobile"] = _mobile;
    map["orderNote"] = _orderNote;
    map["paymentMethod"] = _paymentMethod;
    map["delivery"] = _delivery;
    map["service"] = _service;
    map["status"] = _status;
    return map;
  }

}