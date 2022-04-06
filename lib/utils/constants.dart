import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class APIEndpoints{
  // static String BASE_URL = 'http://deal-station-cms.herokuapp.com';
  static String BASE_URL = 'http://45.76.42.97';

  static String SIGN_UP = '${BASE_URL}/api/v1/auth/member-signup';
  static String LOGIN = '${BASE_URL}/api/v1/auth/member-login';
  static String PHONE_STATUS = '${BASE_URL}/api/v1/auth/phone-status';
  static String LOGOUT = '${BASE_URL}/api/v1/auth/logout/';
  static String CITIES = '${BASE_URL}/api/v1/auth/cities';
  static String SUBSCRIPTION_PLANS = '${BASE_URL}/api/v1/member/membership-plans';
  static String CHILD_SUBSCRIPTION_PLANS = '${BASE_URL}/api/v1/member/membership-subscription';
  static String SUBSCRIBE_PLAN = '${BASE_URL}/api/v1/member/member-subscription';
  static String DASHBOARD = '${BASE_URL}/api/v1/member/offers';
  static String OFFER_DETAIL = '${BASE_URL}/api/v1/member/offer/';
  static String REDEEM_OFFER = '${BASE_URL}/api/v1/member/get-promo';
  static String CAMPAIGNS = '${BASE_URL}/api/v1/member/member-campaigns';
  static String CAMPAIGNS_OFFERS = '${BASE_URL}/api/v1/member/campaign-offers';
  static String PROFILE = '${BASE_URL}/api/v1/auth/member-data';
  static String UPDATE_PROFILE = '${BASE_URL}/api/v1/auth/member-update';
  static String CATEGORIZED_OFFERS = '${BASE_URL}/api/v1/member/category-offers';
  static String FILTER_OFFERS_BY_TYPE = '${BASE_URL}/api/v1/member/promo-offers/';
  static String DISCOVER_OFFERS = '${BASE_URL}/api/v1/member/discover-offers';
}

class NamedRoutes{
  static String routeSplash = '/splash';
  static String routeSignUp = '/signup';
  static const  String routeMain = '/main';
  static String routeExploreCategory = '/exploreCategory';
  static String routePackage = '/package';
  static String routeHome = '/home';
  static String routeCoupon = '/coupon';
  static String routeCredit = '/credit';
  static String routeIntro = '/intro';
  static String routeSettings = '/settings';
  static String routeRegistration = '/registration';
  static String routeOfferDetail = '/adidas';
  static String routeProfile = '/profile';
  static String routeOTP = '/otp';
  static String routeMembership = '/membership';
  static String routeDashboard = '/dashboard';
  static String routeMap = '/map';
  static String routeCampaigns = '/campaigns';
  static String routeDailyPromotions = '/dailyPromotions';

}

class ClickedItemNames{
  static String itemHeart = 'heart';
  static String itemSearch = 'search';
  static String itemProfile = 'profile';
}

class BroadcastEvent{
  static String EVENT_API_ERROR_HANDLING = 'EVENT_API_ERROR_HANDLING';
}

List dropdownItemListCountry = [
  {'label': 'Jaddah', 'value': 'Jaddah'},
  {'label': 'Oman', 'value': 'Oman'},
  {'label': 'Dubai ', 'value': 'Dubai'},
  {'label': 'Makkah', 'value': '  Makkah'},
  // label is required and unique
];

List dropdownItemListGender = [
  {'label': 'Male', 'value': 'Male'},
  {'label': 'Female', 'value': 'Female'},
  // label is required and unique
];

//Global variables
var myNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'label2');
var myScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>(debugLabel: 'label1');
var currentLanguage = 'ar';