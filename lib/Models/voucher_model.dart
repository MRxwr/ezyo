/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"voucher":{"id":"1","code":"NASER20","discount":"20","is_all":"1","vendorId":"0"}}

class VoucherModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  VoucherModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  VoucherModel.fromJson(dynamic json) {
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

/// voucher : {"id":"1","code":"NASER20","discount":"20","is_all":"1","vendorId":"0"}

class Data {
  Voucher _voucher;

  Voucher get voucher => _voucher;

  Data({
      Voucher voucher}){
    _voucher = voucher;
}

  Data.fromJson(dynamic json) {
    _voucher = json["voucher"] != null ? Voucher.fromJson(json["voucher"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_voucher != null) {
      map["voucher"] = _voucher.toJson();
    }
    return map;
  }

}

/// id : "1"
/// code : "NASER20"
/// discount : "20"
/// is_all : "1"
/// vendorId : "0"

class Voucher {
  String _id;
  String _code;
  String _discount;
  String _isAll;
  String _vendorId;

  String get id => _id;
  String get code => _code;
  String get discount => _discount;
  String get isAll => _isAll;
  String get vendorId => _vendorId;

  Voucher({
      String id, 
      String code, 
      String discount, 
      String isAll, 
      String vendorId}){
    _id = id;
    _code = code;
    _discount = discount;
    _isAll = isAll;
    _vendorId = vendorId;
}

  Voucher.fromJson(dynamic json) {
    _id = json["id"];
    _code = json["code"];
    _discount = json["discount"];
    _isAll = json["is_all"];
    _vendorId = json["vendorId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["code"] = _code;
    map["discount"] = _discount;
    map["is_all"] = _isAll;
    map["vendorId"] = _vendorId;
    return map;
  }

}