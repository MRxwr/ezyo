/// ok : false
/// error : "1"
/// status : "Error"
/// data : {"msg":"Payment failed, Please send payment id correctly"}

class PaymentFailedModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  PaymentFailedModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  PaymentFailedModel.fromJson(dynamic json) {
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

/// msg : "Payment failed, Please send payment id correctly"

class Data {
  String _msg;

  String get msg => _msg;

  Data({
      String msg}){
    _msg = msg;
}

  Data.fromJson(dynamic json) {
    _msg = json["msg"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["msg"] = _msg;
    return map;
  }

}