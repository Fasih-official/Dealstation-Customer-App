import 'dart:async';

import 'package:country_code_picker/country_code.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class UIController extends GetxController{

  //otp
  var resendOTPStatus = 60.obs;
  late Timer _timer;

  void startCountDownTimer(){
    resendOTPStatus.value = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      resendOTPStatus.value--;
      if(resendOTPStatus.value < 1){
        timer.cancel();
      }
    });
  }


  //signUp
  var selectedCountryCode = '+966'.obs;

  void onCountryCodePicked(CountryCode code) {
    if(isNotEmpty(code.dialCode)){
      selectedCountryCode.value = code.dialCode!;
    }
  }

}