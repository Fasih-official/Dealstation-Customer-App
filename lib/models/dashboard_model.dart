import 'package:memberApp/models/advertisement_model.dart';

class DashboardModel {
  List<CategoriesBean>? categories;
  List<OffersBean>? offers;
  List<AdvertisementModel>? advertisements;

  static DashboardModel fromMap(Map<String, dynamic> map) {
    DashboardModel dashboardModelBean = DashboardModel();
    dashboardModelBean.categories = []..addAll(
        ((map['categories']?? []) as List).map((o) => CategoriesBean.fromMap(o))
    );
    dashboardModelBean.offers = []..addAll(
        ((map['offers']?? []) as List ).map((o) => OffersBean.fromMap(o))
    );
    dashboardModelBean.advertisements = []..addAll(
        ((map['advertisements']?? []) as List ).map((o) => AdvertisementModel.fromMap(o))
    );
    return dashboardModelBean;
  }

  Map toJson() => {
    "categories": categories,
    "offers": offers,
    "advertisements": advertisements,
  };
}


class OffersBean {
  String? id;
  String? offerName;
  String? offerNameArabic;
  String? offer_description;
  String? offer_description_arabic;
  String? offer_desc_description;
  String? offer_desc_description_arabic;
  dynamic offerImageLink;
  int? offerDiscount;
  String? offerTo;
  String? offerFrom;
  String? offer_blur;
  String? merchant_logo;
  int? offerStatus;

  static OffersBean fromMap(Map<String, dynamic> map) {
    OffersBean offersBean = OffersBean();
    offersBean.id = map['id'] ?? '';
    offersBean.offerName = map['offer_name'] ?? '';
    offersBean.offerNameArabic = map['offer_name_arabic'] ?? '';
    offersBean.offer_description = map['offer_description'] ?? '';
    offersBean.offer_description_arabic = map['offer_description_arabic'] ?? '';
    offersBean.offer_desc_description = map['offer_desc_description'] ?? '';
    offersBean.offer_desc_description_arabic = map['offer_desc_description_arabic'] ?? '';
    offersBean.offerImageLink = map['gallery'] ?? '';
    offersBean.offerDiscount = map['offer_discount']?? 0;
    offersBean.offerTo = map['offer_to']?? '';
    offersBean.offerFrom = map['offer_from'] ?? '';
    offersBean.offer_blur = map['offer_blur'] ?? '';
    offersBean.merchant_logo = map['merchant_logo'] ?? '';
    offersBean.offerStatus = map['offer_status'] ?? 0;
    return offersBean;
  }

  Map toJson() => {
    "id": id,
    "offer_name": offerName,
    "offer_name_arabic": offerNameArabic,
    "offer_description": offer_description,
    "offer_description_arabic": offer_description_arabic,
    "gallery": offerImageLink,
    "offer_discount": offerDiscount,
    "offer_to": offerTo,
    "offer_from": offerFrom,
    "offer_blur": offer_blur,
    "offer_status": offerStatus,
  };
}

class CategoriesBean {
  int? id;
  String? categoryName;
  String? categoryNameArabic;
  String? categoryIcon;

  static CategoriesBean fromMap(Map<String, dynamic> map) {
    CategoriesBean categoriesBean = CategoriesBean();
    categoriesBean.id = map['id'] ?? 0;
    categoriesBean.categoryName = map['category_name'] ?? '';
    categoriesBean.categoryNameArabic = map['category_name_arabic'] ?? '';
    categoriesBean.categoryIcon = map['category_icon'] ?? '';
    return categoriesBean;
  }

  Map toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_name_arabic": categoryNameArabic,
    "category_icon": categoryIcon,
  };
}