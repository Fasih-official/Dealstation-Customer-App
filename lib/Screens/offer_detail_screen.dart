import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberApp/Screens/popups/select_location_sheet.dart';
import 'package:memberApp/models/dashboard_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controlllers/api_controller.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/dialogs.dart';
import '../utils/json_utils.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class OfferDetailScreen extends StatefulWidget {
  const OfferDetailScreen({Key? key}) : super(key: key);

  @override
  _OfferDetailScreenState createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  CarouselController carouselController = CarouselController();
  var activeIndex = 0.obs;

  late APIController controller;
  late String offerID;

  var offer = OffersBean().obs;
  var map = {}.obs;
  String selectedPhoneNumber = '';

  @override
  void initState() {
    super.initState();

    offerID = Get.arguments;

    controller = Get.put(
      APIController(),
      tag: NamedRoutes.routeOfferDetail,
    );

    //listeners
    controller.baseModel.listen((baseModel) async {
      if (baseModel.status!) {
        if (baseModel.message! == 'Offer Fetched Successfully') {
          offer.value = OffersBean.fromMap(baseModel.data);
        } else {
          //Get Code API
          map.value = baseModel.data;
        }
      }
    });

    //API calls
    fetchOfferDetail();
  }

  Future<void> fetchOfferDetail() async {
    controller.baseModel.value = await controller.webservice
        .apiCallOfferDetails(offerID, controller.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      extendBodyBehindAppBar: true,
      body: getBody(size),
      backgroundColor: Colors.white,
    );
  }

  getBody(Size size) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Obx(() {
                return Stack(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: DottedBorder(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: MyCustomScrollBar(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CircularAvatar(
                                        imagePath: '${offer.value.merchant_logo}',
                                        imageSize: 0,
                                        imageHeight: 20,
                                        imageWidth: 90,
                                        isNetworkImage: true,
                                      )
                                    ],
                                  ),
                                  verticalSpace(),
                                  Stack(
                                    children: [
                                      CarouselSlider.builder(
                                        carouselController: carouselController,
                                        itemCount:
                                            (offer.value.offerImageLink ?? [])
                                                .length,
                                        options: CarouselOptions(
                                            height: ((size.height * 0.5) - 80),
                                            autoPlay: true,
                                            viewportFraction: 1,
                                            reverse: false,
                                            aspectRatio: 5.0,
                                            onPageChanged: (index, reason) {
                                              activeIndex.value = index;
                                            }),
                                        itemBuilder: (context, index, id) {
                                          //for onTap to redirect to another screen
                                          return CircularAvatar(
                                            imagePath: offer
                                                .value.offerImageLink?[index],
                                            imageSize: 0,
                                            imageWidth: size.width,
                                            imageHeight: 80,
                                          );
                                        },
                                      ),
                                      Positioned(
                                        left: 10,
                                        bottom: 10,
                                        right: 10,
                                        child: Row(
                                          children: [
                                            Opacity(
                                              opacity: 0.0,
                                              child: Image.asset(
                                                'assets/images/ic_grey_heart.png',
                                                height: 36,
                                              ),
                                            ),
                                            horizontalSpace(),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Obx(() {
                                                  return AnimatedSmoothIndicator(
                                                    activeIndex:
                                                        activeIndex.value,
                                                    count: (offer.value
                                                                .offerImageLink ??
                                                            [])
                                                        .length,
                                                    effect:
                                                        const ScrollingDotsEffect(
                                                            dotWidth: 6.0,
                                                            dotHeight: 6.0,
                                                            activeDotColor:
                                                                Colors.white),
                                                  );
                                                }),
                                              ),
                                            ),
                                            horizontalSpace(),
                                            Image.asset(
                                              'assets/images/ic_grey_heart.png',
                                              height: 36,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  verticalSpace(),
                                  Text(
                                    '${offer.value.offer_description}',
                                    style: regularWhiteText12(
                                      normalTextAndButtonColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  verticalSpace(),
                                  Text(
                                    '${offer.value.offer_desc_description}',
                                    style: regularWhiteText12(
                                      normalTextAndButtonColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  verticalSpace(height: 20),
                                  ((map.value['promo_type'] ?? 'qr') == 'qr')
                                      ? GenericCachedNetworkImage(
                                          imagePath:
                                              '${(map.value['promo']) ?? offer.value.offer_blur}')
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            verticalSpace(),
                                            Text(
                                              '${map.value['promo']}',
                                              style: regularWhiteText24(
                                                normalTextAndButtonColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                  verticalSpace(height: 20),
                                  Column(
                                    children: [
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     onTapSelectLocation(context);
                                      //   },
                                      //   child: Row(
                                      //     mainAxisSize: MainAxisSize.min,
                                      //     children: [
                                      //       Padding(
                                      //         padding: const EdgeInsets.symmetric(
                                      //           horizontal: 5,
                                      //           vertical: 5,
                                      //         ),
                                      //         child: Image.asset(
                                      //           'assets/images/ic_back_arrow.png',
                                      //           height: 12,
                                      //         ),
                                      //       ),
                                      //       Text(
                                      //         "Select Location",
                                      //         style: boldWhiteText14(
                                      //           normalTextAndButtonColor,
                                      //         ),
                                      //         textAlign: TextAlign.center,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // verticalSpace(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          isEmpty(map.value['promo_type'])
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    controller.baseModel.value =
                                                        await controller
                                                            .webservice
                                                            .apiCallRedeemOffer(
                                                                {'id': offerID},
                                                                controller
                                                                    .isLoading);
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        rectangularLighterGreyBoxDecorationWithRadius(
                                                            4),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 40),
                                                      child: CustomizedButton(
                                                        verticalPadding: 10,
                                                        text: 'Get offer',
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  verticalSpace(height: 20),
                                ],
                              ),
                            ),
                          ),
                          color: lightGreyColor,
                          radius: const Radius.circular(8),
                          dashPattern: [6, 6],
                          borderType: BorderType.RRect,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset(
                          "assets/images/ic_discount_background.png",
                          height: 180,
                          width: 180,
                        )),
                    Positioned(
                        top: 50,
                        left: 20,
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              "assets/images/ic_cross.png",
                              height: 50,
                              width: 50,
                            ))),
                    Positioned(
                        top: 100,
                        left: 50,
                        child: Text(
                          "${offer.value.offerDiscount ?? 0}%",
                          style: boldWhiteText32(darkAppBarColor),
                        )),
                  ],
                );
              }),
              GenericProgressBar(tag: NamedRoutes.routeOfferDetail)
            ],
          ),
        ),
      ],
    );
  }

  void onTapSelectLocation(context) {
    showFullWidthDialog(
        context, SelectLocationSheet(), true, DialogType.bottomSheet);
  }
}
