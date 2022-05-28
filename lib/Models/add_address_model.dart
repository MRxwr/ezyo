/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"address":{"id":"5","customerId":"1","country":"kuwait","area":"adan","block":"4","street":"4","house":"4","avenue":"","floor":"4","flat":"4","mobile":"90949089"}}

class AddAddressModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  AddAddressModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  AddAddressModel.fromJson(dynamic json) {
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

/// address : {"id":"5","customerId":"1","country":"kuwait","area":"adan","block":"4","street":"4","house":"4","avenue":"","floor":"4","flat":"4","mobile":"90949089"}

class Data {
  Address _address;

  Address get address => _address;

  Data({
      Address address}){
    _address = address;
}

  Data.fromJson(dynamic json) {
    _address = json["address"] != null ? Address.fromJson(json["address"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_address != null) {
      map["address"] = _address.toJson();
    }
    return map;
  }

}

/// id : "5"
/// customerId : "1"
/// country : "kuwait"
/// area : "adan"
/// block : "4"
/// street : "4"
/// house : "4"
/// avenue : ""
/// floor : "4"
/// flat : "4"
/// mobile : "90949089"

class Address {
  String _id;
  String _customerId;
  String _country;
  String _area;
  String _block;
  String _street;
  String _house;
  String _avenue;
  String _floor;
  String _flat;
  String _mobile;

  String get id => _id;
  String get customerId => _customerId;
  String get country => _country;
  String get area => _area;
  String get block => _block;
  String get street => _street;
  String get house => _house;
  String get avenue => _avenue;
  String get floor => _floor;
  String get flat => _flat;
  String get mobile => _mobile;

  Address({
      String id, 
      String customerId, 
      String country, 
      String area, 
      String block, 
      String street, 
      String house, 
      String avenue, 
      String floor, 
      String flat, 
      String mobile}){
    _id = id;
    _customerId = customerId;
    _country = country;
    _area = area;
    _block = block;
    _street = street;
    _house = house;
    _avenue = avenue;
    _floor = floor;
    _flat = flat;
    _mobile = mobile;
}

  Address.fromJson(dynamic json) {
    _id = json["id"];
    _customerId = json["customerId"];
    _country = json["country"];
    _area = json["area"];
    _block = json["block"];
    _street = json["street"];
    _house = json["house"];
    _avenue = json["avenue"];
    _floor = json["floor"];
    _flat = json["flat"];
    _mobile = json["mobile"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["customerId"] = _customerId;
    map["country"] = _country;
    map["area"] = _area;
    map["block"] = _block;
    map["street"] = _street;
    map["house"] = _house;
    map["avenue"] = _avenue;
    map["floor"] = _floor;
    map["flat"] = _flat;
    map["mobile"] = _mobile;
    return map;
  }

}