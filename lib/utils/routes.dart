import 'package:get/get.dart';
import 'package:memberApp/Screens/splash_screen.dart';
import '../Screens/coupons_screen.dart';
import '../Screens/explore_category_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/intro_screen.dart';
import '../Screens/main_screen.dart';
import '../Screens/membership_screen.dart';
import '../Screens/offer_detail_screen.dart';
import '../Screens/otp_screen.dart';
import '../Screens/packages_screen.dart';
import '../Screens/payment_mode_screen.dart';
import '../Screens/profile_screen.dart';
import '../Screens/sign_up_screen.dart';
import '../screens/Registration_form_screen.dart';
import '../screens/setting_screen.dart';
import 'constants.dart';

class Routes {
  static var pages = [
    GetPage(
      name: NamedRoutes.routeSplash,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: NamedRoutes.routeSignUp,
        page: () => const SignUpScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: NamedRoutes.routeMain,
        page: () => const MainScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: NamedRoutes.routeExploreCategory,
        page: () => const ExploreCategoryScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: NamedRoutes.routePackage,
        page: () => const PackagesScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: NamedRoutes.routeHome,
        page: () => const HomeScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: NamedRoutes.routeCoupon,
        page: () => const CouponsScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: NamedRoutes.routeCredit,
        page: () => const PaymentModeScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: NamedRoutes.routeIntro,
        page: () => const IntroScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: NamedRoutes.routeSettings,
        page: () => const SettingScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
      name: NamedRoutes.routeRegistration,
      page: () => const RegistrationFormScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: NamedRoutes.routeOTP,
      page: () => const OTPScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: NamedRoutes.routeOfferDetail,
      page: () => const OfferDetailScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: NamedRoutes.routeProfile,
      page: () => const ProfileScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: NamedRoutes.routeMembership,
      page: () => const MembershipScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
