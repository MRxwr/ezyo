/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"wallet":"26.5","delivery":"2","service":"0.5","total":"23"}

class CheckoutModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  CheckoutModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  CheckoutModel.fromJson(dynamic json) {
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

/// wallet : "26.5"
/// delivery : "2"
/// service : "0.5"
/// total : "23"

class Data {
  String _wallet;
  String _delivery;
  String _service;
  String _total;

  String get wallet => _wallet;
  String get delivery => _delivery;
  String get service => _service;
  String get total => _total;

  Data({
      String wallet, 
      String delivery, 
      String service, 
      String total}){
    _wallet = wallet;
    _delivery = delivery;
    _service = service;
    _total = total;
}

  Data.fromJson(dynamic json) {
    _wallet = json["wallet"];
    _delivery = json["delivery"];
    _service = json["service"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["wallet"] = _wallet;
    map["delivery"] = _delivery;
    map["service"] = _service;
    map["total"] = _total;
    return map;
  }

}