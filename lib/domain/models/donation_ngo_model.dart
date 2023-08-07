class DonationNgoModel {
  String? donationDocumentid;
  String? ngodocumentId;
  DonationNgoModel({
    this.donationDocumentid,
    this.ngodocumentId,
  });

  Map<String, dynamic> toMap(DonationNgoModel donation) {
    var data = Map<String, dynamic>();
    data['donationDocumentid'] = donation.donationDocumentid;
    data['ngodocumentId'] = donation.ngodocumentId;

    return data;
  }

  DonationNgoModel.fromMap(Map<String, dynamic> mapData) {
    ngodocumentId = mapData['ngodocumentId'];
    donationDocumentid = mapData['donationDocumentid'];
  
  }
}
