class UserModel{
  String? name;
  String? email;
  String? phone;
  String? dob;
  String? city;
  String? token;
  String? tokenType;
  String? expiresAt;

  static UserModel fromMap(Map<String, dynamic> map) {
    UserModel userModelBean = UserModel();
    userModelBean.name = map['name']??'';
    userModelBean.email = map['email']??'';
    userModelBean.phone = map['phone']??'';
    userModelBean.dob = map['dob']??'';
    userModelBean.city = ((map['city'])??0).toString();
    userModelBean.token = map['token']??'';
    userModelBean.tokenType = map['token_type']??'';
    userModelBean.expiresAt = map['expires_at']??'';
    return userModelBean;
  }

  Map toJson() => {
    "name": name,
    "email": email,
    "token": token,
    "token_type": tokenType,
    "expires_at": expiresAt,
  };
}