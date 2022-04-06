class CitiesModel {
  int? id;
  String? cityName;
  String? cityNameArabic;

  static CitiesModel fromMap(Map<String, dynamic> map) {

    CitiesModel citiesModelBean = CitiesModel();
    citiesModelBean.id = map['id']??0;
    citiesModelBean.cityName = map['city_name']??'';
    citiesModelBean.cityNameArabic = map['city_name_arabic']??'';
    return citiesModelBean;
  }

  Map toJson() => {
    "id": id,
    "city_name": cityName,
    "city_name_arabic": cityNameArabic,
  };
}