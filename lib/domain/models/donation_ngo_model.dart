class DonationNgoModel {
  String? ngoUid;
  String? donationDocumentId;
  String? documentId;
  String? ngoName;
  String? donarName;
  String? donarPhone;
  String? sentDate;
  String? sentTime;
  String? donationType;
  String? donationId;
  int? quantity;
  String? ngoDeviceToken;
  String? ngoProfileImage;
  String? ngoAddress;
  String? donarDeviceToken;
  double? donarLat;
  double? donarLong;
    double? ngoLat;
  double? ngoLong;
  String? donationDescription;
  String? donarProfileImage;
  String? donarAddress;
  List<dynamic>? pictures;
  String? status;
  DonationNgoModel({
    this.documentId,
    this.donationId,
    this.ngoLat,
    this.ngoLong,
   this.quantity,
    this.ngoAddress,
    this.ngoDeviceToken,
    this.ngoUid,
   required this.donationType,
    this.ngoName,
    this.sentDate,
    this.sentTime,
    this.ngoProfileImage,
    this.donarLat,
    this.donarLong,
    this.status,
    this.donarAddress,
    this.donarDeviceToken,
    this.donationDescription,
    this.donarName,
    this.donarProfileImage,
    this.donarPhone,
    this.pictures,

  });

  Map<String, dynamic> toMap(DonationNgoModel request) {
    var data = Map<String, dynamic>();
    // data['receiverUid'] = request.receiverUid;
    data['documentId'] = request.documentId;
    data['ngoUid'] = request.ngoUid;
    data['donationType'] = request.donationType;
    data['ngoLat'] = request.ngoLat; 
    data['ngoLong'] = request.ngoLong;
    
    data['status'] = request.status;
    data['ngoAddress'] = request.ngoAddress;
    data['donationId'] = request.donationId;
    data['ngoName'] = request.ngoName;
    data['ngoProfileImage'] = request.ngoProfileImage;
    data['sentDate'] = request.sentDate;
    data['sentTime'] = request.sentTime;
    data['ngoDeviceToken'] = request.ngoDeviceToken;
    data['quantity'] = request.quantity;
    data['donationType'] = request.donationType;
    data['donationDescription'] = request.donationDescription;
    data['donarLat'] =request.donarLat;
    data['donarLong'] = request.donarLong;
    data['donarPhone'] = request.donarPhone;
    data['donarAddress'] = request.donarAddress;
    data['donarName'] = request.donarName;
    data['donarProfileImage'] =request.donarProfileImage;
    data['sentDate'] = request.sentDate;
    data['sentTime'] = request.sentTime;
    data['quantity'] = request.quantity;
    data['donarDeviceToken'] = request.donarDeviceToken;
    data['pictures'] = request.pictures;
    return data;
  }

  DonationNgoModel.fromMap(Map<String, dynamic> mapData) {
    // receiverUid = mapData['receiverUid'];
    documentId = mapData['documentId'];
    donationType = mapData['donationType'];
    ngoName = mapData['ngoName'];
    ngoUid = mapData['ngoUid'];
    quantity =mapData['quantity'];
    donationType=mapData['donationType'];
    ngoAddress = mapData['ngoAddress'];
    donationId = mapData['donationId'];
    status = mapData['status'];
    ngoProfileImage = mapData['ngoProfileImage'];
    sentDate = mapData['sentDate'];
    sentTime = mapData['sentTime'];
    ngoDeviceToken = mapData['ngoDeviceToken'];
     documentId = mapData['documentId'];
    donarName = mapData['donarName'];
    donarLat = mapData['donarLat'];
    donationDescription = mapData['donationDescription'];
    donarLong = mapData['donarLong'];
   ngoLong = mapData['ngoLong'];
    ngoLat = mapData['ngoLat'];
    donarPhone = mapData['donarPhone'];
    donarAddress = mapData['donarAddress'];
    quantity = mapData['quantity'];
    pictures = mapData['pictures'];
    donarProfileImage = mapData['donarProfileImage'];
    sentDate = mapData['sentDate'];
    sentTime = mapData['sentTime'];
    donarDeviceToken = mapData['donarDeviceToken'];
  }
}
