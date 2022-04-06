class CampaignsModel {
  String? id;
  String? campaignName;
  String? campaignNameArabic;
  String? campaignFrom;
  String? campaignTo;
  String? campaignBanner;
  int? offers_count;

  static CampaignsModel fromMap(Map<String, dynamic> map) {
    CampaignsModel campaignsModelBean = CampaignsModel();
    campaignsModelBean.id = map['id']??'';
    campaignsModelBean.campaignName = map['campaign_name']??'';
    campaignsModelBean.campaignNameArabic = map['campaign_name_arabic']??'';
    campaignsModelBean.campaignFrom = map['campaign_from']??'';
    campaignsModelBean.campaignTo = map['campaign_to']??'';
    campaignsModelBean.campaignBanner = map['campaign_banner']??'';
    campaignsModelBean.offers_count = map['offers_count']??0;
    return campaignsModelBean;
  }

  Map toJson() => {
    "id": id,
    "campaign_name": campaignName,
    "campaign_name_arabic": campaignNameArabic,
    "campaign_from": campaignFrom,
    "campaign_to": campaignTo,
    "campaign_banner": campaignBanner,
  };
}