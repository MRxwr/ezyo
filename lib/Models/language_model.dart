/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"language":{"signUp":[{"title":"التسجيل"},{"title":"الاسم"},{"title":"الايميل"},{"title":"كلمة المرور"},{"title":"تاكيد كلمة المرور"},{"title":"تسجيل"}],"signIn":[{"title":"مرحبا بكم في EZYO"},{"title":"الايميل"},{"title":"كلمة المرور"},{"title":"تسجيل الدخول"},{"title":"المتابعة كزائر"},{"title":"أو سجل عبر حساب التواصل الاجتماعي"},{"title":"التسجيل"}],"home":[{"title":"أكل هذا ، ليس هذا"},{"title":"البحث عن مطعم"},{"title":"الكل"},{"title":"برجر"},{"title":"باستا"},{"title":"ستيك"},{"title":"بيتزا"},{"title":"حلويات"},{"title":"أخرى"},{"title":"مشغول"}],"filter":[{"title":"الترتيب حسب"},{"title":"موصى به"},{"title":"الأحدث"},{"title":"من أ إلى ي"},{"title":"الاسرع توصيل"},{"title":"تطبيق"}],"vendor":[{"title":"عرض الطلب"}],"item":[{"title":"طلبات خاصة"},{"title":"طلبات خاصة (اختياري)"},{"title":"إضافة إلى السلة"}],"cart":[{"title":"السلة"},{"title":"طلب خاص"},{"title":"أضافة تعليمات"},{"title":"هل لديك كود خصم؟"},{"title":"أضف كود الخصم"},{"title":"رسوم الخدمات"},{"title":"المبلغ الإجمالي"},{"title":"عنوان"}],"address":[{"title":"العنوان"},{"title":"تحديد الموقع"},{"title":"الاسم"},{"title":"الاسم"},{"title":"الدولة"},{"title":"المنطقة"},{"title":"اختر المنطقة"},{"title":"المنطقة"},{"title":"الشارع"},{"title":"المنزل"},{"title":"الجادة"},{"title":"اختياري"},{"title":"الطابق"},{"title":"اختياري"},{"title":"الشقة"},{"title":"اختياري"},{"title":"رقم الهاتف"},{"title":"رقم الهاتف "},{"title":"الدفع"}],"checkout":[{"title":"الدفع"},{"title":"اختار طريقة الدفع"},{"title":"كي-نت"},{"title":"فيزا/ماستركارد"},{"title":"محفظة"},{"title":"رسوم التوصيل"},{"title":"رسوم الخدمات"},{"title":"المبلغ الإجمالي"},{"title":"دفع"}],"success":[{"title":"العملية ناجحة"},{"title":"تفاصيل الطلب"},{"title":"طريقة الدفع "},{"title":"رسوم التوصيل"},{"title":"رسوم الخدمات"},{"title":"المبلغ الإجمالي"},{"title":"الصفحة الرئيسية"}],"fail":[{"title":"عملية فاشلة"},{"title":"عملية دفع فاشلة"},{"title":"حاول مجددا"},{"title":"الصفحة الرئيسية"}],"track":[{"title":"متابعة الطلب"},{"title":"تم التوصيل"},{"title":"جاري تجهيز الطلب"},{"title":"خارج للتوصيل"},{"title":"طلب ملغي"},{"title":"ليس لديك اي طلبات"},{"title":"اطلب الان"}],"settings":[{"title":"الإعدادات"},{"title":"المحفظة"},{"title":"تغيير كلمة المرور"},{"title":"اللغة"},{"title":"إنجليزي"},{"title":"عربي"},{"title":"الشروط و الاحكام"},{"title":"سياسة خاصة"},{"title":"تسجيل خروج"},{"title":"version 5.0.1"}],"profile":[{"title":"الملف الشخصي"},{"title":"الاسم"},{"title":"الايميل"},{"title":"رقم الهاتف"},{"title":"تحديث"}],"changePassword":[{"title":"تغيير كلمة المرور"},{"title":"كلمة المرور الحالية"},{"title":"كلمة مرور جديدة"},{"title":" تاكيد كلمة المرور  "},{"title":"تحديث"}],"language":[{"title":"اللغة"},{"title":"العربية"},{"title":"English"}]}}

class LanguageModel {
  bool _ok;
  String _error;
  String _status;
  Data _data;

  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  LanguageModel({
      bool ok, 
      String error, 
      String status, 
      Data data}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  LanguageModel.fromJson(dynamic json) {
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

/// language : {"signUp":[{"title":"التسجيل"},{"title":"الاسم"},{"title":"الايميل"},{"title":"كلمة المرور"},{"title":"تاكيد كلمة المرور"},{"title":"تسجيل"}],"signIn":[{"title":"مرحبا بكم في EZYO"},{"title":"الايميل"},{"title":"كلمة المرور"},{"title":"تسجيل الدخول"},{"title":"المتابعة كزائر"},{"title":"أو سجل عبر حساب التواصل الاجتماعي"},{"title":"التسجيل"}],"home":[{"title":"أكل هذا ، ليس هذا"},{"title":"البحث عن مطعم"},{"title":"الكل"},{"title":"برجر"},{"title":"باستا"},{"title":"ستيك"},{"title":"بيتزا"},{"title":"حلويات"},{"title":"أخرى"},{"title":"مشغول"}],"filter":[{"title":"الترتيب حسب"},{"title":"موصى به"},{"title":"الأحدث"},{"title":"من أ إلى ي"},{"title":"الاسرع توصيل"},{"title":"تطبيق"}],"vendor":[{"title":"عرض الطلب"}],"item":[{"title":"طلبات خاصة"},{"title":"طلبات خاصة (اختياري)"},{"title":"إضافة إلى السلة"}],"cart":[{"title":"السلة"},{"title":"طلب خاص"},{"title":"أضافة تعليمات"},{"title":"هل لديك كود خصم؟"},{"title":"أضف كود الخصم"},{"title":"رسوم الخدمات"},{"title":"المبلغ الإجمالي"},{"title":"عنوان"}],"address":[{"title":"العنوان"},{"title":"تحديد الموقع"},{"title":"الاسم"},{"title":"الاسم"},{"title":"الدولة"},{"title":"المنطقة"},{"title":"اختر المنطقة"},{"title":"المنطقة"},{"title":"الشارع"},{"title":"المنزل"},{"title":"الجادة"},{"title":"اختياري"},{"title":"الطابق"},{"title":"اختياري"},{"title":"الشقة"},{"title":"اختياري"},{"title":"رقم الهاتف"},{"title":"رقم الهاتف "},{"title":"الدفع"}],"checkout":[{"title":"الدفع"},{"title":"اختار طريقة الدفع"},{"title":"كي-نت"},{"title":"فيزا/ماستركارد"},{"title":"محفظة"},{"title":"رسوم التوصيل"},{"title":"رسوم الخدمات"},{"title":"المبلغ الإجمالي"},{"title":"دفع"}],"success":[{"title":"العملية ناجحة"},{"title":"تفاصيل الطلب"},{"title":"طريقة الدفع "},{"title":"رسوم التوصيل"},{"title":"رسوم الخدمات"},{"title":"المبلغ الإجمالي"},{"title":"الصفحة الرئيسية"}],"fail":[{"title":"عملية فاشلة"},{"title":"عملية دفع فاشلة"},{"title":"حاول مجددا"},{"title":"الصفحة الرئيسية"}],"track":[{"title":"متابعة الطلب"},{"title":"تم التوصيل"},{"title":"جاري تجهيز الطلب"},{"title":"خارج للتوصيل"},{"title":"طلب ملغي"},{"title":"ليس لديك اي طلبات"},{"title":"اطلب الان"}],"settings":[{"title":"الإعدادات"},{"title":"المحفظة"},{"title":"تغيير كلمة المرور"},{"title":"اللغة"},{"title":"إنجليزي"},{"title":"عربي"},{"title":"الشروط و الاحكام"},{"title":"سياسة خاصة"},{"title":"تسجيل خروج"},{"title":"version 5.0.1"}],"profile":[{"title":"الملف الشخصي"},{"title":"الاسم"},{"title":"الايميل"},{"title":"رقم الهاتف"},{"title":"تحديث"}],"changePassword":[{"title":"تغيير كلمة المرور"},{"title":"كلمة المرور الحالية"},{"title":"كلمة مرور جديدة"},{"title":" تاكيد كلمة المرور  "},{"title":"تحديث"}],"language":[{"title":"اللغة"},{"title":"العربية"},{"title":"English"}]}

class Data {
  Language _language;

  Language get language => _language;

  Data({
      Language language}){
    _language = language;
}

  Data.fromJson(dynamic json) {
    _language = json["language"] != null ? Language.fromJson(json["language"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_language != null) {
      map["language"] = _language.toJson();
    }
    return map;
  }

}

/// signUp : [{"title":"التسجيل"},{"title":"الاسم"},{"title":"الايميل"},{"title":"كلمة المرور"},{"title":"تاكيد كلمة المرور"},{"title":"تسجيل"}]
/// signIn : [{"title":"مرحبا بكم في EZYO"},{"title":"الايميل"},{"title":"كلمة المرور"},{"title":"تسجيل الدخول"},{"title":"المتابعة كزائر"},{"title":"أو سجل عبر حساب التواصل الاجتماعي"},{"title":"التسجيل"}]
/// home : [{"title":"أكل هذا ، ليس هذا"},{"title":"البحث عن مطعم"},{"title":"الكل"},{"title":"برجر"},{"title":"باستا"},{"title":"ستيك"},{"title":"بيتزا"},{"title":"حلويات"},{"title":"أخرى"},{"title":"مشغول"}]
/// filter : [{"title":"الترتيب حسب"},{"title":"موصى به"},{"title":"الأحدث"},{"title":"من أ إلى ي"},{"title":"الاسرع توصيل"},{"title":"تطبيق"}]
/// vendor : [{"title":"عرض الطلب"}]
/// item : [{"title":"طلبات خاصة"},{"title":"طلبات خاصة (اختياري)"},{"title":"إضافة إلى السلة"}]
/// cart : [{"title":"السلة"},{"title":"طلب خاص"},{"title":"أضافة تعليمات"},{"title":"هل لديك كود خصم؟"},{"title":"أضف كود الخصم"},{"title":"رسوم الخدمات"},{"title":"المبلغ الإجمالي"},{"title":"عنوان"}]
/// address : [{"title":"العنوان"},{"title":"تحديد الموقع"},{"title":"الاسم"},{"title":"الاسم"},{"title":"الدولة"},{"title":"المنطقة"},{"title":"اختر المنطقة"},{"title":"المنطقة"},{"title":"الشارع"},{"title":"المنزل"},{"title":"الجادة"},{"title":"اختياري"},{"title":"الطابق"},{"title":"اختياري"},{"title":"الشقة"},{"title":"اختياري"},{"title":"رقم الهاتف"},{"title":"رقم الهاتف "},{"title":"الدفع"}]
/// checkout : [{"title":"الدفع"},{"title":"اختار طريقة الدفع"},{"title":"كي-نت"},{"title":"فيزا/ماستركارد"},{"title":"محفظة"},{"title":"رسوم التوصيل"},{"title":"رسوم الخدمات"},{"title":"المبلغ الإجمالي"},{"title":"دفع"}]
/// success : [{"title":"العملية ناجحة"},{"title":"تفاصيل الطلب"},{"title":"طريقة الدفع "},{"title":"رسوم التوصيل"},{"title":"رسوم الخدمات"},{"title":"المبلغ الإجمالي"},{"title":"الصفحة الرئيسية"}]
/// fail : [{"title":"عملية فاشلة"},{"title":"عملية دفع فاشلة"},{"title":"حاول مجددا"},{"title":"الصفحة الرئيسية"}]
/// track : [{"title":"متابعة الطلب"},{"title":"تم التوصيل"},{"title":"جاري تجهيز الطلب"},{"title":"خارج للتوصيل"},{"title":"طلب ملغي"},{"title":"ليس لديك اي طلبات"},{"title":"اطلب الان"}]
/// settings : [{"title":"الإعدادات"},{"title":"المحفظة"},{"title":"تغيير كلمة المرور"},{"title":"اللغة"},{"title":"إنجليزي"},{"title":"عربي"},{"title":"الشروط و الاحكام"},{"title":"سياسة خاصة"},{"title":"تسجيل خروج"},{"title":"version 5.0.1"}]
/// profile : [{"title":"الملف الشخصي"},{"title":"الاسم"},{"title":"الايميل"},{"title":"رقم الهاتف"},{"title":"تحديث"}]
/// changePassword : [{"title":"تغيير كلمة المرور"},{"title":"كلمة المرور الحالية"},{"title":"كلمة مرور جديدة"},{"title":" تاكيد كلمة المرور  "},{"title":"تحديث"}]
/// language : [{"title":"اللغة"},{"title":"العربية"},{"title":"English"}]

class Language {
  List<SignUp> _signUp;
  List<SignIn> _signIn;
  List<Home> _home;
  List<Filter> _filter;
  List<Vendor> _vendor;
  List<Item> _item;
  List<Cart> _cart;
  List<Address> _address;
  List<Checkout> _checkout;
  List<Success> _success;
  List<Fail> _fail;
  List<Track> _track;
  List<Settings> _settings;
  List<Profile> _profile;
  List<ChangePassword> _changePassword;
  List<Lang> _language;

  List<SignUp> get signUp => _signUp;
  List<SignIn> get signIn => _signIn;
  List<Home> get home => _home;
  List<Filter> get filter => _filter;
  List<Vendor> get vendor => _vendor;
  List<Item> get item => _item;
  List<Cart> get cart => _cart;
  List<Address> get address => _address;
  List<Checkout> get checkout => _checkout;
  List<Success> get success => _success;
  List<Fail> get fail => _fail;
  List<Track> get track => _track;
  List<Settings> get settings => _settings;
  List<Profile> get profile => _profile;
  List<ChangePassword> get changePassword => _changePassword;
  List<Lang> get language => _language;

  Language({
      List<SignUp> signUp, 
      List<SignIn> signIn, 
      List<Home> home, 
      List<Filter> filter, 
      List<Vendor> vendor, 
      List<Item> item, 
      List<Cart> cart, 
      List<Address> address, 
      List<Checkout> checkout, 
      List<Success> success, 
      List<Fail> fail, 
      List<Track> track, 
      List<Settings> settings, 
      List<Profile> profile, 
      List<ChangePassword> changePassword, 
      List<Lang> language}){
    _signUp = signUp;
    _signIn = signIn;
    _home = home;
    _filter = filter;
    _vendor = vendor;
    _item = item;
    _cart = cart;
    _address = address;
    _checkout = checkout;
    _success = success;
    _fail = fail;
    _track = track;
    _settings = settings;
    _profile = profile;
    _changePassword = changePassword;
    _language = language;
}

  Language.fromJson(dynamic json) {
    if (json["signUp"] != null) {
      _signUp = [];
      json["signUp"].forEach((v) {
        _signUp.add(SignUp.fromJson(v));
      });
    }
    if (json["signIn"] != null) {
      _signIn = [];
      json["signIn"].forEach((v) {
        _signIn.add(SignIn.fromJson(v));
      });
    }
    if (json["home"] != null) {
      _home = [];
      json["home"].forEach((v) {
        _home.add(Home.fromJson(v));
      });
    }
    if (json["filter"] != null) {
      _filter = [];
      json["filter"].forEach((v) {
        _filter.add(Filter.fromJson(v));
      });
    }
    if (json["vendor"] != null) {
      _vendor = [];
      json["vendor"].forEach((v) {
        _vendor.add(Vendor.fromJson(v));
      });
    }
    if (json["item"] != null) {
      _item = [];
      json["item"].forEach((v) {
        _item.add(Item.fromJson(v));
      });
    }
    if (json["cart"] != null) {
      _cart = [];
      json["cart"].forEach((v) {
        _cart.add(Cart.fromJson(v));
      });
    }
    if (json["address"] != null) {
      _address = [];
      json["address"].forEach((v) {
        _address.add(Address.fromJson(v));
      });
    }
    if (json["checkout"] != null) {
      _checkout = [];
      json["checkout"].forEach((v) {
        _checkout.add(Checkout.fromJson(v));
      });
    }
    if (json["success"] != null) {
      _success = [];
      json["success"].forEach((v) {
        _success.add(Success.fromJson(v));
      });
    }
    if (json["fail"] != null) {
      _fail = [];
      json["fail"].forEach((v) {
        _fail.add(Fail.fromJson(v));
      });
    }
    if (json["track"] != null) {
      _track = [];
      json["track"].forEach((v) {
        _track.add(Track.fromJson(v));
      });
    }
    if (json["settings"] != null) {
      _settings = [];
      json["settings"].forEach((v) {
        _settings.add(Settings.fromJson(v));
      });
    }
    if (json["profile"] != null) {
      _profile = [];
      json["profile"].forEach((v) {
        _profile.add(Profile.fromJson(v));
      });
    }
    if (json["changePassword"] != null) {
      _changePassword = [];
      json["changePassword"].forEach((v) {
        _changePassword.add(ChangePassword.fromJson(v));
      });
    }
    if (json["language"] != null) {
      _language = [];
      json["language"].forEach((v) {
        _language.add(Lang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_signUp != null) {
      map["signUp"] = _signUp.map((v) => v.toJson()).toList();
    }
    if (_signIn != null) {
      map["signIn"] = _signIn.map((v) => v.toJson()).toList();
    }
    if (_home != null) {
      map["home"] = _home.map((v) => v.toJson()).toList();
    }
    if (_filter != null) {
      map["filter"] = _filter.map((v) => v.toJson()).toList();
    }
    if (_vendor != null) {
      map["vendor"] = _vendor.map((v) => v.toJson()).toList();
    }
    if (_item != null) {
      map["item"] = _item.map((v) => v.toJson()).toList();
    }
    if (_cart != null) {
      map["cart"] = _cart.map((v) => v.toJson()).toList();
    }
    if (_address != null) {
      map["address"] = _address.map((v) => v.toJson()).toList();
    }
    if (_checkout != null) {
      map["checkout"] = _checkout.map((v) => v.toJson()).toList();
    }
    if (_success != null) {
      map["success"] = _success.map((v) => v.toJson()).toList();
    }
    if (_fail != null) {
      map["fail"] = _fail.map((v) => v.toJson()).toList();
    }
    if (_track != null) {
      map["track"] = _track.map((v) => v.toJson()).toList();
    }
    if (_settings != null) {
      map["settings"] = _settings.map((v) => v.toJson()).toList();
    }
    if (_profile != null) {
      map["profile"] = _profile.map((v) => v.toJson()).toList();
    }
    if (_changePassword != null) {
      map["changePassword"] = _changePassword.map((v) => v.toJson()).toList();
    }
    if (_language != null) {
      map["language"] = _language.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "اللغة"

class Lang {
  String _title;

  String get title => _title;

  Lang({
      String title}){
    _title = title;
}

  Lang.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "تغيير كلمة المرور"

class ChangePassword {
  String _title;

  String get title => _title;

  ChangePassword({
      String title}){
    _title = title;
}

  ChangePassword.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "الملف الشخصي"

class Profile {
  String _title;

  String get title => _title;

  Profile({
      String title}){
    _title = title;
}

  Profile.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "الإعدادات"

class Settings {
  String _title;

  String get title => _title;

  Settings({
      String title}){
    _title = title;
}

  Settings.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "متابعة الطلب"

class Track {
  String _title;

  String get title => _title;

  Track({
      String title}){
    _title = title;
}

  Track.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "عملية فاشلة"

class Fail {
  String _title;

  String get title => _title;

  Fail({
      String title}){
    _title = title;
}

  Fail.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "العملية ناجحة"

class Success {
  String _title;

  String get title => _title;

  Success({
      String title}){
    _title = title;
}

  Success.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "الدفع"

class Checkout {
  String _title;

  String get title => _title;

  Checkout({
      String title}){
    _title = title;
}

  Checkout.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "العنوان"

class Address {
  String _title;

  String get title => _title;

  Address({
      String title}){
    _title = title;
}

  Address.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "السلة"

class Cart {
  String _title;

  String get title => _title;

  Cart({
      String title}){
    _title = title;
}

  Cart.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "طلبات خاصة"

class Item {
  String _title;

  String get title => _title;

  Item({
      String title}){
    _title = title;
}

  Item.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "عرض الطلب"

class Vendor {
  String _title;

  String get title => _title;

  Vendor({
      String title}){
    _title = title;
}

  Vendor.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "الترتيب حسب"

class Filter {
  String _title;

  String get title => _title;

  Filter({
      String title}){
    _title = title;
}

  Filter.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "أكل هذا ، ليس هذا"

class Home {
  String _title;

  String get title => _title;

  Home({
      String title}){
    _title = title;
}

  Home.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "مرحبا بكم في EZYO"

class SignIn {
  String _title;

  String get title => _title;

  SignIn({
      String title}){
    _title = title;
}

  SignIn.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// title : "التسجيل"

class SignUp {
  String _title;

  String get title => _title;

  SignUp({
      String title}){
    _title = title;
}

  SignUp.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}