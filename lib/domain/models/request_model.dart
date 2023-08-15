class RequestModel {
  // String? receiverUid;
  String? senderUid;
  String? documentId;
  String? senderName;
  String? senderPhone;
  String? sentDate;
  String? sentTime;
  String? donationType;
  String? serviceId;
  int? quantity;
  String? status;
  String? description;
  String? senderDeviceToken;
  double? senderLat;
  double? senderLong;
  String? senderProfileImage;
  
  String? senderAddress;
  RequestModel({
    // this.receiverUid,
    this.documentId,
    this.serviceId,
    // this.senderLat,
    // this.senderLong,
   required this.description,
   required this.quantity,
    this.senderAddress,
    this.senderDeviceToken,
    this.senderUid,
   required this.donationType,
    this.senderName,
    this.sentDate,
    this.sentTime,
   this.status,
   this.senderLat,
   this.senderLong,
    this.senderProfileImage,
    this.senderPhone,
  });

  Map<String, dynamic> toMap(RequestModel request) {
    var data = Map<String, dynamic>();
    // data['receiverUid'] = request.receiverUid;
    data['documentId'] = request.documentId;
    data['senderUid'] = request.senderUid;
    data['donationType'] = request.donationType;
    data['senderLat'] = request.senderLat;
    data['senderLong'] = request.senderLong;
    data['senderPhone'] = request.senderPhone;
    data['senderAddress'] = request.senderAddress;
    data['serviceId'] = request.serviceId;
    data['senderName'] = request.senderName;
    data['senderProfileImage'] = request.senderProfileImage;
    data['sentDate'] = request.sentDate;
    data['sentTime'] = request.sentTime;
    data['senderDeviceToken'] = request.senderDeviceToken;
    data['quantity'] = request.quantity;
    data['description'] = request.description;
    data['status'] = request.status;
    
    data['donationType'] = request.donationType;

    return data;
  }

  RequestModel.fromMap(Map<String, dynamic> mapData) {
    // receiverUid = mapData['receiverUid'];
    documentId = mapData['documentId'];
    donationType = mapData['donationType'];
    senderName = mapData['senderName'];
    senderUid = mapData['senderUid'];
    description = mapData['description'];
    quantity =mapData['quantity'];
    donationType=mapData['donationType'];
    
    senderLat=mapData['senderLat'];
    senderLong=mapData['senderLong'];
    senderPhone = mapData['senderPhone'];
    senderAddress = mapData['senderAddress'];
    serviceId = mapData['serviceId'];
    senderProfileImage = mapData['senderProfileImage'];
    sentDate = mapData['sentDate'];
    sentTime = mapData['sentTime'];
    status = mapData['status'];
    senderDeviceToken = mapData['senderDeviceToken'];
  }

  // bool equals(RequestModel user) => user.uid == this.uid;
}
