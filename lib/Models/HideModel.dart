/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"hide":"1"}

class HideModel {
  HideModel({
      bool ok, 
      String error, 
      String status, 
      Data data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  HideModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _ok;
  String _error;
  String _status;
  Data _data;
HideModel copyWith({  bool ok,
  String error,
  String status,
  Data data,
}) => HideModel(  ok: ok ?? _ok,
  error: error ?? _error,
  status: status ?? _status,
  data: data ?? _data,
);
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

/// hide : "1"

class Data {
  Data({
      String hide,}){
    _hide = hide;
}

  Data.fromJson(dynamic json) {
    _hide = json['hide'];
  }
  String _hide;
Data copyWith({  String hide,
}) => Data(  hide: hide ?? _hide,
);
  String get hide => _hide;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hide'] = _hide;
    return map;
  }

}