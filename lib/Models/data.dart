/// version : "1.0.0"
/// enTerms : "english terms"
/// arTerms : "arabic terms"
/// enPolicy : "english policy"
/// arPolicy : "arabic policy"
/// whatsapp : "96590949089"
/// wallet : "17"

class Data {
  Data({
      String version, 
      String enTerms, 
      String arTerms, 
      String enPolicy, 
      String arPolicy, 
      String whatsapp, 
      String wallet,}){
    _version = version;
    _enTerms = enTerms;
    _arTerms = arTerms;
    _enPolicy = enPolicy;
    _arPolicy = arPolicy;
    _whatsapp = whatsapp;
    _wallet = wallet;
}

  Data.fromJson(dynamic json) {
    _version = json['version'];
    _enTerms = json['enTerms'];
    _arTerms = json['arTerms'];
    _enPolicy = json['enPolicy'];
    _arPolicy = json['arPolicy'];
    _whatsapp = json['whatsapp'];
    _wallet = json['wallet'];
  }
  String _version;
  String _enTerms;
  String _arTerms;
  String _enPolicy;
  String _arPolicy;
  String _whatsapp;
  String _wallet;

  String get version => _version;
  String get enTerms => _enTerms;
  String get arTerms => _arTerms;
  String get enPolicy => _enPolicy;
  String get arPolicy => _arPolicy;
  String get whatsapp => _whatsapp;
  String get wallet => _wallet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = _version;
    map['enTerms'] = _enTerms;
    map['arTerms'] = _arTerms;
    map['enPolicy'] = _enPolicy;
    map['arPolicy'] = _arPolicy;
    map['whatsapp'] = _whatsapp;
    map['wallet'] = _wallet;
    return map;
  }

}