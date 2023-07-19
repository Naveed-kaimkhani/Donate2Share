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
  String? donatorProfileImage;
  String? donatorAddress;
  double? quantity;
  String? expiry;

  DonationModel({
    // this.receiverUid,
    this.documentId,
    this.donationId,
    this.donatorLat,
    this.donatorLong,
    this.donatorAddress,
    this.donatorDeviceToken,
    this.donatorUid,
    this.expiry,
    this.quantity,
    this.donatorName,
    this.sentDate,
    this.sentTime,
    this.donatorProfileImage,
    this.donatorPhone,
  });

  Map<String, dynamic> toMap(DonationModel request) {
    var data = Map<String, dynamic>();
    // data['receiverUid'] = request.receiverUid;
    data['documentId'] = request.documentId;
    data['donatorUid'] = request.donatorUid;
    data['donatorLat'] = request.donatorLat;
    data['donatorLong'] = request.donatorLong;
    data['donatorPhone'] = request.donatorPhone;
    data['donatorAddress'] = request.donatorAddress;
    data['donationId'] = request.donationId;
    data['donatorName'] = request.donatorName;
    data['donatorProfileImage'] = request.donatorProfileImage;
    data['sentDate'] = request.sentDate;
    data['sentTime'] = request.sentTime;
    data['donatorDeviceToken'] = request.donatorDeviceToken;

    return data;
  }

  DonationModel.fromMap(Map<String, dynamic> mapData) {
    // receiverUid = mapData['receiverUid'];
    documentId = mapData['documentId'];
    donatorName = mapData['donatorName'];
    donatorUid = mapData['donatorUid'];
    donatorLat = mapData['donatorLat'];
    donatorLong = mapData['donatorLong'];
    donatorPhone = mapData['donatorPhone'];
    donatorAddress = mapData['donatorAddress'];
    donationId = mapData['donationId'];
    donatorProfileImage = mapData['donatorProfileImage'];
    sentDate = mapData['sentDate'];
    sentTime = mapData['sentTime'];
    donatorDeviceToken = mapData['donatorDeviceToken'];
  }

  // bool equals(DonationModel user) => user.uid == this.uid;
}
