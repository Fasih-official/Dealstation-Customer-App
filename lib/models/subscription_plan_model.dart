
class SubscriptionPlanModel {
  int? id;
  String? subscriptionName;
  String? subscriptionArabic;
  int? subscriptionDuration;
  dynamic subscriptionPrice;
  String? cityName;
  String? cityNameArabic;

  static SubscriptionPlanModel fromMap(Map<String, dynamic> map) {

    SubscriptionPlanModel subscriptionPlanModelBean = SubscriptionPlanModel();
    subscriptionPlanModelBean.id = map['id'] ?? 0;
    subscriptionPlanModelBean.subscriptionName = map['subscription_name'] ?? '';
    subscriptionPlanModelBean.subscriptionArabic = map['subscription_arabic'] ?? '';
    subscriptionPlanModelBean.subscriptionDuration = map['subscription_duration'] ?? 0;
    subscriptionPlanModelBean.subscriptionPrice = map['subscription_price'] ?? 0;
    subscriptionPlanModelBean.cityName = map['city_name'] ?? '';
    subscriptionPlanModelBean.cityNameArabic = map['city_name_arabic'] ?? '';
    return subscriptionPlanModelBean;
  }

  Map toJson() => {
    "id": id,
    "subscription_name": subscriptionName,
    "subscription_arabic": subscriptionArabic,
    "subscription_duration": subscriptionDuration,
    "subscription_price": subscriptionPrice,
    "city_name": cityName,
    "city_name_arabic": cityNameArabic,
  };
}