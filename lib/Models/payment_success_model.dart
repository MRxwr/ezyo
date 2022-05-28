/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"orderId":"1025828","status":"success"}

class PaymentSuccessModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  PaymentSuccessModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  PaymentSuccessModel.fromJson(dynamic json) {
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

/// orderId : "1025828"
/// status : "success"

class Data {
  String _orderId;
  String _status;

  String get orderId => _orderId;
  String get status => _status;

  Data({
      String orderId, 
      String status}){
    _orderId = orderId;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _orderId = json["orderId"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["orderId"] = _orderId;
    map["status"] = _status;
    return map;
  }

}