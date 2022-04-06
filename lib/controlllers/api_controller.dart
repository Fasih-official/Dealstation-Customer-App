import 'package:get/get.dart';

import '../models/base_model.dart';
import '../services/web_services.dart';

class APIController extends GetxController{
  var isLoading = false.obs;
  var baseModel = BaseModel().obs;

  var webservice = Webservice();

}