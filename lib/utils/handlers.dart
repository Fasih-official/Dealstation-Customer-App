import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:memberApp/utils/constants.dart';

class Handlers{
  static final Handlers _singleton = Handlers._internal();

  factory Handlers() {
    return _singleton;
  }

  Handlers._internal();

  void apiResponseHandler(response){
    if(response.statusCode == 401){
      FBroadcast.instance().broadcast(BroadcastEvent.EVENT_API_ERROR_HANDLING,value: {
        'statusCode':response.statusCode,
        'errMsg':'User session has expired.'
      });
    }else if(response.statusCode == 404){

    }else if((response.statusCode??500) >= 500){

    }else {
      FBroadcast.instance().broadcast(BroadcastEvent.EVENT_API_ERROR_HANDLING,value: {
        'statusCode':response.statusCode,
        'errMsg':jsonDecode(response.body)['data'][0]
      });
    }
  }

  void apiExceptionHandler(e,Function(String errMsg) onError){
    if(e is FirebaseAuthException){
      if(e.code == 'account-exists-with-different-credential'){
        onError('This email is already registered');
      }else if(e.code == 'invalid-credential'){
        onError('Your credentials has expired. Please try again');
      }else if(e.code == 'user-not-found'){
        onError('No user exists with the provided email');
      }else if(e.code == 'invalid-verification-code'){
        onError('Verification code mismatched');
      }else if(e.code == 'invalid-verification-id'){
        onError('Verification ID is not valid');
      }else if(e.code == 'invalid-phone-number'){
        onError('Provided Phone number is not valid. (E.g, Valid Ph No: +923481234567)');
      }else{
        onError('${e.message}');
      }
    }
  }
}