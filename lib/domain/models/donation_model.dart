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
String? riderChoise;
List<dynamic>? pictures;
  DonationModel({
    // this.receiverUid,
    this.documentId,
    this.donationId,
    this.donatorLat,
    this.donatorLong,
    this.riderChoise,
    this.donatorAddress,
    this.donatorDeviceToken,
    this.donatorUid,
    this.expiry,
    this.quantity,
    this.type,
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
    data['riderChoise'] = donation.riderChoise;

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
    donatorLong = mapData['donatorLong'];
    donatorPhone = mapData['donatorPhone'];
    donatorAddress = mapData['donatorAddress'];
    donationId = mapData['donationId'];
    riderChoise = mapData['riderChoise'];
    donatorProfileImage = mapData['donatorProfileImage'];
    sentDate = mapData['sentDate'];
    sentTime = mapData['sentTime'];
    donatorDeviceToken = mapData['donatorDeviceToken'];
  }

  // bool equals(DonationModel user) => user.uid == this.uid;
}
