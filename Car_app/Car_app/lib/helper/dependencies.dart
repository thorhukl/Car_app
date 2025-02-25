import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/figure_controller.dart';
import 'package:food_app/controller/location_controller.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/controller/order_history_controller.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/controller/user_controller.dart';
import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/data/repository/auth_repo.dart';
import 'package:food_app/data/repository/cart_repo.dart';
import 'package:food_app/data/repository/food_repo.dart';
import 'package:food_app/data/repository/location_repo.dart';
import 'package:food_app/data/repository/order_history_repo.dart';
import 'package:food_app/data/repository/order_repo.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/data/repository/recommended_product_repo.dart';
import 'package:food_app/data/repository/user_repo.dart';
import 'package:food_app/models/order_history_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(
      apiclient: Get.find(), sharedPreferences: Get.find(), apiClient: null));
  //repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  Get.lazyPut(() => FoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderHistoryRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));

  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => FigureController(foodRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => OrderHistoryController(orderHistoryRepo: Get.find()));
}
