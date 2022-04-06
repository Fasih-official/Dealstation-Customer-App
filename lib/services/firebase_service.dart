import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:memberApp/controlllers/api_controller.dart';
import 'package:memberApp/utils/constants.dart';

import '../utils/handlers.dart';
import '../utils/utils.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();

  factory FirebaseService() {
    return _singleton;
  }

  FirebaseService._internal();

  Future<void> serviceVerifyPhoneNumber({
    phoneNumber = '+44 7123 123 456',
    required Function(PhoneAuthCredential credential) verificationCompleted,
    required Function(FirebaseAuthException e) verificationFailed,
    required Function(String verificationId, int? resendToken) codeSent,
  }) async {
    return await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<UserCredential> loginUser(credential) async {
    APIController controller = Get.find(tag: NamedRoutes.routeOTP);
    try {
      controller.isLoading.value = true;
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      controller.isLoading.value = false;
      return userCredential;
    } catch (e) {
      controller.isLoading.value = false;
      Handlers().apiExceptionHandler(e, (errMsg) {
        showToast(errMsg);
      });
      return Future.error(e);
    }
  }
}
