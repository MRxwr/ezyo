class CartModel {
  String tileAr;
  String titleEn;
  String descriptionAr;
  String descriptionEn;
  String imageUrl;
  String id;
  String vendorId;
  String orderNote;
  int quantity;
  String price;
  String discount;
  String finalPrice;
  String vendorTitleAr;
  String vendorTitleEn;
  String vendorImage;
  List<String> times;
  String startDate;
  CartModel({this.tileAr,this.titleEn,this.descriptionAr,this.descriptionEn,
    this.imageUrl,this.id,this.vendorId,this.orderNote,
  this.quantity,this.price,this.discount,this.finalPrice,this.vendorTitleAr,this.vendorTitleEn,this.vendorImage,this.times,this.startDate});
}