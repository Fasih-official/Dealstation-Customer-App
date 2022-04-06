import 'dart:convert';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controlllers/api_controller.dart';
import '../models/cities_model.dart';
import '../models/user_model.dart';
import '../utils/app_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({Key? key}) : super(key: key);

  @override
  _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  var selectedItemGender = 'Male';
  DateTime? selectedDate = null;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();

  var selectedCityID = -1;

  late APIController controller;

  var cities = [].obs;

  var phoneNumber = '';

  @override
  void initState() {
    super.initState();
    controller = Get.put(APIController(), tag: NamedRoutes.routeRegistration);

    var mapArgs = Get.arguments;
    phoneNumber = mapArgs['phone'];

    fetchCities();
    controller.baseModel.listen((baseModel) {
      if (baseModel.message!.contains('Cities')) {
        cities.value = (baseModel.data as List)
            .map((e) => CitiesModel.fromMap(e))
            .toList();
      } else {
        if (baseModel.status!) {
          navigateUserToPage(baseModel,route: NamedRoutes.routePackage);
        }
      }
    });
  }

  Future<void> fetchCities() async {
    controller.baseModel.value =
    await controller.webservice.apiCallFetchCities(controller.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return MyScaffold(
      body: getBody(size),
    );
  }

  getBody(Size size) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/ic_bg_sign_up.png",
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              verticalSpace(height: 20),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyBackButton(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          tr('Registration Form'),
                          style: boldWhiteText18(normalTextAndButtonColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration:
                  rectangularYellowBoxDecorationWithRadiusElevation(160, 2),
                  child: MyCustomScrollBar(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                decoration:
                                rectangularWhiteBoxDecorationWithRadiusElevation(
                                    20, 4),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 12),
                                  child: MyTextField(
                                    hint: "Enter Name",
                                    controller: _nameController,

                                    // descriptionController: _phoneNumber,
                                  ),
                                ),
                              ),
                            ),
                            verticalSpace(height: 20),
                            Container(
                              width: size.width - 20,
                              decoration:
                              rectangularWhiteBoxDecorationWithRadiusElevation(
                                  20, 4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14.0, horizontal: 12),
                                child: Text(
                                  "${phoneNumber}",
                                ),
                              ),
                            ),
                            verticalSpace(height: 20),
                            Obx(() {
                              return Container(
                                decoration:
                                rectangularWhiteBoxDecorationWithRadiusElevation(
                                    20, 4),
                                child: CoolDropdown(
                                  dropdownList: List.generate(
                                    cities.value.length,
                                        (index) {
                                      return {
                                        'label': (cities
                                            .value[index] as CitiesModel)
                                            .cityName,
                                        'value': (cities
                                            .value[index] as CitiesModel)
                                            .cityName,
                                      };
                                    },
                                  ).toList(),
                                  dropdownWidth: size.width - 60,
                                  resultWidth: size.width - 20,
                                  resultHeight: 50,
                                  selectedItemBD: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  selectedItemTS:
                                  regularWhiteText18(Colors.white),
                                  defaultValue: {
                                    'label': 'Choose City',
                                    'value': 'Choose City',
                                  },
                                  resultPadding: EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  resultBD:
                                  rectangularWhiteBoxDecorationWithRadiusElevation(
                                      20, 2),
                                  resultTS: regularWhiteText14(Colors.black),
                                  resultIcon: Image.asset(
                                    "assets/images/ic_arrow_down.png",
                                    height: 16,
                                    width: 16,
                                    color: Colors.grey,
                                  ),
                                  onChange: (item) {
                                    var selectedItemCountry =
                                    (item as Map)['value'] as String;
                                    selectedCityID =
                                        (cities.value as List<CitiesModel>)
                                            .where((element) =>
                                        element.cityName == selectedItemCountry)
                                            .toList()[0].id ?? -1;
                                  },
                                ),
                              );
                            }),
                            verticalSpace(height: 20),
                            Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: Container(
                                        decoration:
                                        rectangularWhiteBoxDecorationWithRadiusElevation(
                                            20, 4),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                isEmpty(selectedDate)?"Enter date of birth":"${selectedDate!.day.toString().padLeft(2,'0')}-${selectedDate!.month.toString().padLeft(2,'0')}-${selectedDate!.year.toString().padLeft(2,'0')}",
                                              ),
                                              Image.asset(
                                                "assets/images/ic_arrow_down.png",
                                                height: 16,
                                                width: 16,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ), // DOB
                            verticalSpace(height: 20),
                            Container(
                              decoration:
                              rectangularWhiteBoxDecorationWithRadiusElevation(
                                  20, 4),
                              child: CoolDropdown(
                                dropdownList: dropdownItemListGender,
                                dropdownWidth: size.width - 60,
                                resultWidth: size.width - 20,
                                resultHeight: 50,
                                selectedItemBD: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(20)),
                                selectedItemTS:
                                regularWhiteText18(Colors.white),
                                defaultValue: dropdownItemListGender[0],
                                resultPadding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                resultBD:
                                rectangularWhiteBoxDecorationWithRadiusElevation(
                                    20, 2),
                                resultTS: regularWhiteText14(Colors.black),
                                resultIcon: Image.asset(
                                  "assets/images/ic_arrow_down.png",
                                  height: 16,
                                  width: 16,
                                  color: Colors.grey,
                                ),
                                onChange: (item) {
                                  selectedItemGender = (item as Map)['value'] as String;
                                },
                              ),
                            ), // gender
                            verticalSpace(height: 20),
                            Container(
                              decoration:
                              rectangularWhiteBoxDecorationWithRadiusElevation(
                                  20, 10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14.0, horizontal: 12),
                                child: MyTextField(
                                  hint: "Email",
                                  controller: _emailController,
                                ),
                              ),
                            ), //email
                            verticalSpace(height: 20),
                            Container(
                              decoration:
                              rectangularWhiteBoxDecorationWithRadiusElevation(
                                  20, 10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14.0, horizontal: 12),
                                child: MyTextField(
                                  hint: "Confirm Email",
                                  controller: _confirmEmailController,
                                ),
                              ),
                            ), //confirm email
                            verticalSpace(height: 20),
                            Container(
                              decoration:
                              rectangularWhiteBoxDecorationWithRadiusElevation(
                                  20, 4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14.0, horizontal: 12),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: 16,
                                        width: 16,
                                        child: Radio(
                                            value: true,
                                            groupValue: true,
                                            onChanged: (value) {})),
                                    horizontalSpace(),
                                    Expanded(
                                      child: Text(
                                        "I agree to the terms and conditions",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            verticalSpace(height: 20),
                            Text("hello Lorem Ibsumn"),
                            verticalSpace(height: 20),
                            GestureDetector(
                              onTap: () {
                                onTapRegister(context);
                              },
                              child: Container(
                                decoration:
                                rectangularDarkAppBarBoxDecorationWithRadiusElevation(
                                    10, 2),
                                child: CustomizedButton(
                                  text: tr('Register Now'),
                                  verticalPadding: 20,
                                  textColor: Colors.white,
                                  img: '',
                                ),
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        GenericProgressBar(tag: NamedRoutes.routeRegistration,)
      ],
    );
  }

  _selectDate(BuildContext context) async {
    selectedDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    bool isValid = true;
    if (isEmpty(_nameController.text)) {
      showToast("Name should not be empty");
      isValid = false;
    } else if (selectedCityID == -1) {
      showToast("Please choose the city");
      isValid = false;
    } else if (DateTime
        .now()
        .difference(isEmpty(selectedDate)?DateTime.now():selectedDate!)
        .inDays < 4383) {
      showToast("You must be 12 years old");
      isValid = false;
    } else if (isEmpty(_emailController.text)) {
      showToast("Email should not be empty");
      isValid = false;
    } else if (!(_emailController.text.contains('@')) &&
        !(_emailController.text.endsWith('.com'))) {
      showToast("Please use correct email");
      isValid = false;
    } else if (isEmpty(_confirmEmailController.text)) {
      showToast("Confirm Email field should not be empty");
      isValid = false;
    } else if (_emailController.text != _confirmEmailController.text) {
      showToast("Both Emails should be same");
      isValid = false;
    } else {
      isValid = true;
    }

    return isValid;
  }

  void onTapRegister(BuildContext context) async {
    if (_validateFields()) {
      controller.baseModel.value = await controller.webservice.apiCallSignUp({
        'name': _nameController.text,
        'email': _emailController.text,
        'password': 'Abcd1234@',
        'confirm-password': 'Abcd1234@',
        'phone': phoneNumber,
        'dob': formatDate(selectedDate!),
        'gender': selectedItemGender,
        'city': selectedCityID.toString(),
      }, controller.isLoading);
    }
  }
}
