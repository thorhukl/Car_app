import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/data/repository/food_repo.dart';
import 'package:food_app/models/product_model.dart';
import 'package:get/get.dart';

class FigureController extends GetxController {
  final FoodRepo foodRepo;
  FigureController({required this.foodRepo});

  List<dynamic> _foodList = [];
  List<dynamic> get foodList => _foodList;

  List<dynamic> _foodListSearch = [];
  List<dynamic> get foodListSearch => _foodListSearch;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItem => _inCartItems + _quantity;

  late CartController _cart;

  Future<void> getAllFoodList() async {
    Response response = await foodRepo.getAllFoodList();
    if (response.statusCode == 200) {
      _isLoaded = true;
      _foodList = [];
      _foodList.addAll(Product.fromJson(response.body).products);
      update();
    } else {
      print("Failed to load food list");
    }
  }

  Future<void> searchProduct(String? query) async {
    update();
    if (query == null || query.isEmpty) {
      _foodListSearch.clear();
      _isLoaded = true;
      update();
      return;
    }

    Response response = await foodRepo.searchFood(query);

    if (response.statusCode == 200) {
      _foodListSearch = [];
      if (Product.fromJson(response.body).products.isNotEmpty) {
        _foodListSearch.addAll(Product.fromJson(response.body).products);
        _isLoaded = true;
      } else {
        _isLoaded = false;
        return;
      }
      update();
    } else {
      print("Failed to search food");
    }
    update();
  }

  // search by id in foodList
  ProductModel getFoodById(int id) {
    for (ProductModel product in _foodList) {
      if (product.id == id) {
        return product;
      }
    }
    return ProductModel();
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool exist = _cart.existedInCart(product);
    print("Exist or not: " + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("The quantity is: " + _inCartItems.toString());
  }
}
