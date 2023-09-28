import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/seller_model.dart';
import '../domain/models/user_model.dart';

class StorageService {
  static late SharedPreferences _sharedPreferences;

  static Future<void> saveUser(UserModel sellerModel) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(
        'user', json.encode(sellerModel.toMap(sellerModel)));
  }

  static Future<int?> checkUserInitialization() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? isUser = preferences.getInt('isNGO');
    return isUser;
  }

// static Future<int?> checkScreenInitialization()async{

//           SharedPreferences preferences = await SharedPreferences.getInstance();
//           // await preferences.getInt('initScreen');
//          return preferences.getInt('initScreen');
// }
  static Future<void> initNGO() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.setInt('initScreen', 1);
    await preferences.setInt('isNGO', 1);
    print("ngooo initedddd");
    print(preferences.getInt('isNGO'));
  }

  static Future<void> saveAdmin(UserModel sellerModel) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(
        'admin', json.encode(sellerModel.toMap(sellerModel)));
  }

  static Future<void> saveSeller(SellerModel sellerModel) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(
        'admin', json.encode(sellerModel.toMap(sellerModel)));
  }

  static Future<SellerModel?> readUser() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString('user') == null
        ? null
        : SellerModel.fromMap(
            json.decode(_sharedPreferences.getString('user')!));
  }

  static Future<SellerModel?> readSeller() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString('seller') == null
        ? null
        : SellerModel.fromMap(
            json.decode(_sharedPreferences.getString('seller')!));
  }

  // static Future<List<SellerModel?>> readSellersData() async {
  //   _sharedPreferences = await SharedPreferences.getInstance();
  //   return _sharedPreferences.getString('AllSellersData') == null
  //       ? null
  //       : SellerModel.fromMap(
  //           json.decode(_sharedPreferences.getString('seller')!));
  // }

  static Future<void> clear() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.clear();
  }
}
