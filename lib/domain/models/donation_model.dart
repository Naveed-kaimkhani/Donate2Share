class DonationModel {
  // String? receiverUid;
  String? donarUid;
  String? documentId;
  String? donarName;
  String? donarPhone;
  String? sentDate;
  String? sentTime;
  String? type;
  String? donationId;
  String? donarDeviceToken;
  double? donarLat;
  double? donarLong;
  String? donationDescription;
  String? donarProfileImage;
  String? donarAddress;
  int? quantity;
  String? expiry;
  String? needRider;

  String? month;
  List<dynamic>? pictures;
  DonationModel({
    // this.receiverUid,
    this.documentId,
    this.donationId,
    this.donarLat,
    this.donarLong,
    this.needRider,
    this.donarAddress,
    this.donarDeviceToken,
    this.donationDescription,
    this.donarUid,
    this.expiry,
    this.quantity,
    this.type,
    this.month,
    this.donarName,
    this.sentDate,
    this.sentTime,
    this.donarProfileImage,
    this.donarPhone,
    this.pictures,
  });

  Map<String, dynamic> toMap(DonationModel donation) {
    var data = Map<String, dynamic>();
    // data['receiverUid'] = donation.receiverUid;
    data['documentId'] = donation.documentId;
    data['donarUid'] = donation.donarUid;

    data['donationDescription'] = donation.donationDescription;
    data['donarLat'] = donation.donarLat;
    data['donarLong'] = donation.donarLong;
    data['donarPhone'] = donation.donarPhone;
    data['donarAddress'] = donation.donarAddress;
    data['donationId'] = donation.donationId;
    data['donarName'] = donation.donarName;
    data['donarProfileImage'] = donation.donarProfileImage;
    data['type'] = donation.type;
    data['sentDate'] = donation.sentDate;
    data['sentTime'] = donation.sentTime;
    data['needRider'] = donation.needRider;
    data['quantity'] = donation.quantity;
    data['month'] = donation.month;

    data['donarDeviceToken'] = donation.donarDeviceToken;

    data['pictures'] = donation.pictures;

    return data;
  }

  DonationModel.fromMap(Map<String, dynamic> mapData) {
    // receiverUid = mapData['receiverUid'];
    print("in frommap");
    documentId = mapData['documentId'];
    donarName = mapData['donarName'];
    donarUid = mapData['donarUid'];
    donarLat = mapData['donarLat'];
    type = mapData['type'];

    month = mapData['month'];
    donationDescription = mapData['donationDescription'];
    donarLong = mapData['donarLong'];
    donarPhone = mapData['donarPhone'];
    donarAddress = mapData['donarAddress'];
    donationId = mapData['donationId'];
    needRider = mapData['needRider'];
    quantity = mapData['quantity'];

    pictures = mapData['pictures'];
    donarProfileImage = mapData['donarProfileImage'];
    sentDate = mapData['sentDate'];
    sentTime = mapData['sentTime'];
    donarDeviceToken = mapData['donarDeviceToken'];
  }

  // bool equals(DonationModel user) => user.uid == this.uid;
}
