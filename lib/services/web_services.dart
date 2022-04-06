import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;

import '../models/base_model.dart';
import '../utils/app_preferences.dart';
import '../utils/constants.dart';
import '../utils/handlers.dart';

class Webservice {
  static final Webservice _singleton = Webservice._internal();

  factory Webservice() {
    return _singleton;
  }

  Webservice._internal();

  Future<BaseModel> apiCallSignUp(Map jsonMap, RxBool isLoading) async {
    isLoading.value = true;

    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
    };

    var jsonBody = jsonEncode(jsonMap);

    var response = await http.post(Uri.parse(APIEndpoints.SIGN_UP),
        headers: headers,
        body: jsonBody,
        encoding: Encoding.getByName("utf-8"));

    isLoading.value = false;
    print(response);
    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallSignIn(Map jsonMap, RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
    };

    isLoading.value = true;

    var jsonBody = jsonEncode(jsonMap);

    var response = await http.post(Uri.parse(APIEndpoints.LOGIN),
        headers: headers,
        body: jsonBody,
        encoding: Encoding.getByName("utf-8"));

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallPhoneStatus(Map jsonMap, RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
    };

    isLoading.value = true;

    var jsonBody = jsonEncode(jsonMap);

    var response = await http.post(Uri.parse(APIEndpoints.PHONE_STATUS),
        headers: headers,
        body: jsonBody,
        encoding: Encoding.getByName("utf-8"));

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchCities(RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse(APIEndpoints.CITIES),
      headers: headers,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchMemberPlans(RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse(APIEndpoints.SUBSCRIPTION_PLANS),
      headers: headers,
    );
    print(response);

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      print(responseMap);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchChildMemberPlans(planID,RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse('${APIEndpoints.CHILD_SUBSCRIPTION_PLANS}/${planID}'),
      headers: headers,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallSubscribeChildMemberPlan(Map jsonMap,RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var jsonBody = jsonEncode(jsonMap);

    var response = await http.post(Uri.parse(APIEndpoints.SUBSCRIBE_PLAN),
        headers: headers,
        body: jsonBody,
        encoding: Encoding.getByName("utf-8"));

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallRedeemOffer(Map jsonMap,RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var jsonBody = jsonEncode(jsonMap);

    var response = await http.post(Uri.parse(APIEndpoints.REDEEM_OFFER),
        headers: headers,
        body: jsonBody,
        encoding: Encoding.getByName("utf-8"));

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallCategorizedOffers(categoryID,RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var jsonBody = jsonEncode({
      "id":categoryID
    });

    var response = await http.post(Uri.parse(APIEndpoints.CATEGORIZED_OFFERS),
        headers: headers,
        body: jsonBody,
        encoding: Encoding.getByName("utf-8"));

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallLogout(RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse(APIEndpoints.LOGOUT),
      headers: headers,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallOfferDetails(String offerID,RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse('${APIEndpoints.OFFER_DETAIL}${offerID}'),
      headers: headers,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchDashboardData(RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse('${APIEndpoints.DASHBOARD}'),
      headers: headers,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchCampaigns(RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse('${APIEndpoints.CAMPAIGNS}'),
      headers: headers,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallCampaignOffers(String offerID,RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var jsonBody = jsonEncode({
      'id':offerID
    });

    var response = await http.post(Uri.parse(APIEndpoints.CAMPAIGNS_OFFERS),
        headers: headers,
        body: jsonBody,
        encoding: Encoding.getByName("utf-8"));

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchProfile(RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse('${APIEndpoints.PROFILE}'),
      headers: headers,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchOffersByType(String type,RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse('${APIEndpoints.FILTER_OFFERS_BY_TYPE}?type=${type}'),
      headers: headers,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchDiscoveryOffers(RxBool isLoading) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var response = await http.get(
      Uri.parse('${APIEndpoints.DISCOVER_OFFERS}'),
      headers: headers,
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallUpdateProfile(Map jsonMap,RxBool isLoading) async {

    // {
    // "name":"Demo Person",
    // "email":"jamil12@gmail.com",
    // "confirm-password":"Demo@123",
    // "phone":"+223456789012",
    // "dob":"10-03-2022",
    // "gender":"Male",
    // "city":"1"
    // }

    Map<String, String> headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${globalPreferences?.getString(AppPreferences.TOKEN)}",
    };

    isLoading.value = true;

    var jsonBody = jsonEncode(jsonMap);

    var response = await http.post(Uri.parse(APIEndpoints.UPDATE_PROFILE),
        headers: headers,
        body: jsonBody,
        encoding: Encoding.getByName("utf-8"));

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return BaseModel.fromMap(responseMap);
    } else {
      Handlers().apiResponseHandler(response);
      return BaseModel.fromMap(null);
    }
  }

}


