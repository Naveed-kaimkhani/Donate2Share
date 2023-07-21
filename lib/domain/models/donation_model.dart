class DonationModel {
  // String? receiverUid;
  String? donatorUid;
  String? documentId;
  String? donatorName;
  String? donatorPhone;
  String? sentDate;
  String? sentTime;
  String? type;
  String? donationId;
  String? donatorDeviceToken;
  double? donatorLat;
 
  double? donatorLong;
  String? donationDescription;
  String? donatorProfileImage;
  String? donatorAddress;
  String? quantity;
  String? expiry;
  String? needRider;
  
  String? month;
  List<dynamic>? pictures;
  DonationModel({
    // this.receiverUid,
    this.documentId,
    this.donationId,
    this.donatorLat,
    this.donatorLong,
    this.needRider,
    this.donatorAddress,
    this.donatorDeviceToken,
    this.donationDescription,
    this.donatorUid,
    this.expiry,
    this.quantity,
    this.type,
    this.month,
    this.donatorName,
    this.sentDate,
    this.sentTime,
    this.donatorProfileImage,
    this.donatorPhone,
    this.pictures,
  });

  Map<String, dynamic> toMap(DonationModel donation) {
    var data = Map<String, dynamic>();
    // data['receiverUid'] = donation.receiverUid;
    data['documentId'] = donation.documentId;
    data['donatorUid'] = donation.donatorUid;

    data['donationDescription'] = donation.donationDescription;
    data['donatorLat'] = donation.donatorLat;
    data['donatorLong'] = donation.donatorLong;
    data['donatorPhone'] = donation.donatorPhone;
    data['donatorAddress'] = donation.donatorAddress;
    data['donationId'] = donation.donationId;
    data['donatorName'] = donation.donatorName;
    data['donatorProfileImage'] = donation.donatorProfileImage;
    data['type'] = donation.type;
    data['sentDate'] = donation.sentDate;
    data['sentTime'] = donation.sentTime;
    data['needRider'] = donation.needRider;
    data['quantity'] = donation.quantity;
    data['month'] = donation.month;

    data['donatorDeviceToken'] = donation.donatorDeviceToken;

    data['pictures'] = donation.pictures;

    return data;
  }

  DonationModel.fromMap(Map<String, dynamic> mapData) {
    // receiverUid = mapData['receiverUid'];
    documentId = mapData['documentId'];
    donatorName = mapData['donatorName'];
    donatorUid = mapData['donatorUid'];
    donatorLat = mapData['donatorLat'];
    type = mapData['type'];
    
    month = mapData['month'];
    donationDescription = mapData['donationDescription'];
    donatorLong = mapData['donatorLong'];
    donatorPhone = mapData['donatorPhone'];
    donatorAddress = mapData['donatorAddress'];
    donationId = mapData['donationId'];
    needRider = mapData['needRider'];
    quantity = mapData['quantity'];

    pictures = mapData['pictures'];
    donatorProfileImage = mapData['donatorProfileImage'];
    sentDate = mapData['sentDate'];
    sentTime = mapData['sentTime'];
    donatorDeviceToken = mapData['donatorDeviceToken'];
  }

  // bool equals(DonationModel user) => user.uid == this.uid;
}
