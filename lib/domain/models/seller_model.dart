
// Seller --> Donar (individual/restaurant/organization)
class SellerModel {
   String? uid;
  String? profileImage;
  String? name;
 String? phone;
  String? email;
 String? address;
  double? lat;
  double? long;
String? type;
String? deviceToken;

  SellerModel({
  this.lat,
  this.long,
  required this.uid,
 required   this.profileImage,
   required this.name,
  required  this.phone,
  required  this.email,
  required this.address,
  required this.deviceToken,
this.type,

  });

  
  Map<String, dynamic> toMap(SellerModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['profileImage'] = user.profileImage;
    data['name'] = user.name;
    data['lat'] = user.lat;
    data['long'] = user.long;
    data['phone'] = user.phone;
    data['email'] = user.email;
    data['deviceToken'] = user.deviceToken;
    data['address'] = user.address;
  data['type'] = user.type;
  
    return data;
  }

  
  SellerModel.fromMap(Map<String, dynamic> mapData) {
    uid = mapData['uid'];
    profileImage = mapData['profileImage'];
    name = mapData['name'];
    phone = mapData['phone'];
     lat = mapData['lat'];
    long = mapData['long'];
    email = mapData['email'];
     address = mapData['address'];
     type = mapData['type'];
    deviceToken = mapData['deviceToken'];
    
  }

}
