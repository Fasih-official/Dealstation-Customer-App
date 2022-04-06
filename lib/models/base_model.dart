import '../utils/utils.dart';

class BaseModel{
  bool? status;
  String? message;
  dynamic data;

  static BaseModel fromMap(Map<String, dynamic>? map) {
    if(isNotEmpty(map)){
      BaseModel baseModelBean = BaseModel();
      baseModelBean.data = map!['data'];
      baseModelBean.message = map['message'];
      baseModelBean.status = map['status'];
      return baseModelBean;
    }else{
      BaseModel baseModelBean = BaseModel();
      baseModelBean.data = null;
      baseModelBean.message = 'Something went wrong';
      baseModelBean.status = false;
      return baseModelBean;
    }
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "status": status,
  };
}