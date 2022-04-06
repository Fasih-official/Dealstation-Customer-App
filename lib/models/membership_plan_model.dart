class MembershipPlanModel {
  int? id;
  String? planName;
  String? planNameArabic;
  String? planIcon;
  String? planTerms;

  static MembershipPlanModel fromMap(Map<String, dynamic> map) {
    MembershipPlanModel membershipPlanModelBean = MembershipPlanModel();
    membershipPlanModelBean.id = map['id']??0;
    membershipPlanModelBean.planName = map['plan_name']??'';
    membershipPlanModelBean.planNameArabic = map['plan_name_arabic']??'';
    membershipPlanModelBean.planIcon = map['plan_icon']??'';
    membershipPlanModelBean.planTerms = map['plan_terms']??'';
    return membershipPlanModelBean;
  }

  Map toJson() => {
    "id": id,
    "plan_name": planName,
    "plan_name_arabic": planNameArabic,
    "plan_icon": planIcon,
    "plan_terms": planTerms,
  };
}