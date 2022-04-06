class AdvertisementModel {
  int? advertisementType;
  String? advertisementName;
  String? advertisementText;
  String? advertisementImage;

  static AdvertisementModel fromMap(Map<String, dynamic> map) {
    AdvertisementModel advertisementModelBean = AdvertisementModel();
    advertisementModelBean.advertisementType = map['advertisement_type']??0;
    advertisementModelBean.advertisementName = map['advertisement_name']??'';
    advertisementModelBean.advertisementText = map['advertisement_text']??'';
    advertisementModelBean.advertisementImage = map['advertisement_image']??'';
    return advertisementModelBean;
  }

  Map toJson() => {
    "advertisement_type": advertisementType,
    "advertisement_name": advertisementName,
    "advertisement_text": advertisementText,
    "advertisement_image": advertisementImage,
  };
}