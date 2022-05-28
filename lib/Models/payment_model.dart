/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"orderId":1004357,"url":"https://demo.MyFatoorah.com/En/KWT/PayInvoice/Checkout?invoiceKey=01072100435740&paymentGatewayId=22"}

class PaymentModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  PaymentModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  PaymentModel.fromJson(dynamic json) {
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

/// orderId : 1004357
/// url : "https://demo.MyFatoorah.com/En/KWT/PayInvoice/Checkout?invoiceKey=01072100435740&paymentGatewayId=22"

class Data {
  int _orderId;
  String _url;

  int get orderId => _orderId;
  String get url => _url;

  Data({
      int orderId, 
      String url}){
    _orderId = orderId;
    _url = url;
}

  Data.fromJson(dynamic json) {
    _orderId = json["orderId"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["orderId"] = _orderId;
    map["url"] = _url;
    return map;
  }

}