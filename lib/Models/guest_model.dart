/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"id":"7"}

class GuestModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  GuestModel({
      bool ok,
      String error,
      String status,
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  GuestModel.fromJson(dynamic json) {
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

/// id : "7"

class Data {
  String _id;

  String get id => _id;

  Data({
      String id}){
    _id = id;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    return map;
  }

}