import 'data.dart';

/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"version":"1.0.0","enTerms":"english terms","arTerms":"arabic terms","enPolicy":"english policy","arPolicy":"arabic policy","whatsapp":"96590949089","wallet":"17"}

class SettingsModel {
  SettingsModel({
      bool ok, 
      String error, 
      String status, 
      Data data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  SettingsModel.fromJson(dynamic json) {
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