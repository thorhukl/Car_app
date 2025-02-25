import 'package:food_app/data/repository/auth_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/models/update_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);

    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("an");
      print("token: " + response.body["token"]);
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      print("xit");
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();

    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      //print("loi:" + response.statusCode.toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // Future<ResponseModel> updateInfor(UpdateModel updateModel) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await authRepo.updateUserInfor(updateModel);

  //   late ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     print("xit");
  //     responseModel = ResponseModel(false, response.statusText!);
  //   }

  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearShareData() {
    return authRepo.clearSharedData();
  }
}
