/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"name":"nasser hatb","email":"nasserhatab@gmail.com"}

class UpdateProfileModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  UpdateProfileModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  UpdateProfileModel.fromJson(dynamic json) {
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

/// name : "nasser hatb"
/// email : "nasserhatab@gmail.com"

class Data {
  String _name;
  String _email;

  String get name => _name;
  String get email => _email;

  Data({
      String name, 
      String email}){
    _name = name;
    _email = email;
}

  Data.fromJson(dynamic json) {
    _name = json["name"];
    _email = json["email"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["email"] = _email;
    return map;
  }

}