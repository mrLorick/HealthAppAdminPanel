import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_helpers.dart';


class SharedPreferenceHelper {
  static late SharedPreferences _prefsInstance;

  static final SharedPreferenceHelper _singleton =
      SharedPreferenceHelper._internal();

  SharedPreferenceHelper._internal() {
    SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  factory SharedPreferenceHelper() {
    return _singleton;
  }

  static const String _userModel = "userModel";
  static const String _rememberMeModel = "rememberMeModel";
  static const String _rememberMeBussModel = "rememberMeBussModel";
  static const String _savedLanguage = 'savedLanguage';

  static const String _contacts = "contacts";
  static const String _contractSample = "contractSample";
  static const String _searchValues = "searchValues";

  // static const String _fcmToken = "fcmToken";
  static const String _userType = "userType";
  static const String _userRole = "userRole";
  static const String _bankDetail = "bankDetail";
  static const String _userToken = "userToken";
  static const String _userName = "_userName";
  static const String _isLoggedIn = "isLoggedIn";
  static const String _paymentCards = "paymentCards";

  static const JsonDecoder _decoder = JsonDecoder();
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  Future<dynamic> _savePref(String key, Object? value) async {
    var prefs = _prefsInstance;
    if (prefs.containsKey(key)) {
      prefs.remove(key);
    }
    if (value is bool) {
      return await prefs.setBool(key, value);
    } else if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is List<String>) {
      return await prefs.setStringList(key, value);
    } else if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else {
      return null;
    }
  }

  T _getPref<T>(String key) {
    return _prefsInstance.get(key) as T;
  }

  // Future<void> clearAll() async {
  //   final remember = getRememberMeModel();
  //   final rememberBusiness = getRememberMeBussModel();
  //   await _prefsInstance.clear();
  //   // await _prefsInstance.remove(_userToken);
  //   await rememberMe(remember);
  //   await rememberMeBuss(rememberBusiness);
  //   // _prefsInstance.
  // }

  void clear() {
    _prefsInstance.clear();
  }

  // BankModel? getBankDetail() {
  //   final data = _getPref(_bankDetail);
  //   if (data == null) return null;
  //   final model = BankModel.fromJson(jsonDecode(data));
  //   return model;
  // }
  //
  // Future<void> saveBankDetail(BankModel bankModel) async {
  //   await _savePref(_bankDetail, jsonEncode(bankModel.toJson()));
  // }

  Future<void> saveSearchValues(List<String> searchValue) async {
    await _savePref(_searchValues, searchValue);
  }

  List<String>? getSearchValues() {
    final list = _getPref(_searchValues);
    if (list != null) {
      return List<String>.generate(
          list.length, (index) => list[index].toString());
    }
    return <String>[];
  }

  int? getUserType() {
    return _getPref(_userType);
  }

  bool? getIsUserAdminRole() {
    return _getPref(_userRole);
  }


  Future<void> saveUserType(int type) async {
    printLog("<<<<<<<<<<< save user type >>>>>>>>>");
    await _savePref(_userType, type);
  }

  // /// Save Payment Cards
  // Future<void> savePaymentCards(List<PaymentCardData> cards) async {
  //   List<String> cardStringList =
  //       cards.map((card) => json.encode(card.toJson())).toList();
  //   await _savePref(_paymentCards, cardStringList);
  // }

  // /// Get Payment Cards
  // List<PaymentCardData> getPaymentCards()  {
  //   List<dynamic> cardStringList = _getPref(_paymentCards) ?? [];
  //   return cardStringList
  //       .map((cardString) => PaymentCardData.fromJson(json.decode(cardString)))
  //       .toList();
  // }



  Future<void> saveUserName(String? name) async {
    await _savePref(_userName, name ?? "");
  }

  Future<void> saveIsAdminRole(bool? role) async {
    await _savePref(_userRole, role ?? false);
  }


  String? getUserName() {
    return _getPref(_userName);
  }

  String? getUserToken() {
    return _getPref(_userToken);
  }

  Future<void> saveUserToken(String? token) async {
    await _savePref(_userToken, token ?? "");
  }

  bool getIsLoggedIn() {
    return _getPref(_isLoggedIn) ?? false;
  }

  // bool haveSubscription() {
  //   final user = getUserModel();
  //   return user?.isSubscribed ?? false;
  // }
  //
  // Future<void> saveUserModel(UserModel? userModel) async {
  //   if (userModel != null) {
  //     String value = _encoder.convert(userModel);
  //     await _savePref(_userModel, value);
  //   } else {
  //     await _savePref(_userModel, null);
  //   }
  // }

  // Future<void> rememberMe(RememberMeModel? rememberMeModel) async {
  //   printLog("rememberMeModel>>>${rememberMeModel?.toJson()}");
  //   if (rememberMeModel != null) {
  //     String value = _encoder.convert(rememberMeModel);
  //     await _savePref(_rememberMeModel, value);
  //   } else {
  //     await _savePref(_rememberMeModel, null);
  //   }
  // }

  // Future<void> rememberMeBuss(RememberMeModel? rememberMeModel) async {
  //   printLog("rememberMeModel>>>${rememberMeModel?.toJson()}");
  //   if (rememberMeModel != null) {
  //     String value = _encoder.convert(rememberMeModel);
  //     await _savePref(_rememberMeBussModel, value);
  //   } else {
  //     await _savePref(_rememberMeBussModel, null);
  //   }
  // }

  Future<void> saveContact(List<Map<dynamic, dynamic>> contactList) async {
    await _savePref(
        _contacts, contactList.map((json) => jsonEncode(json)).toList());

    printLog("==============saveContact==========");
  }

  // List<PhoneContactModel>? getContact() {
  //   dynamic user = _getPref(_contacts);
  //   if (user != null) {
  //     return List<PhoneContactModel>.from(
  //         user.map((json) => PhoneContactModel.fromJson(jsonDecode(json))));
  //   } else {
  //     return null;
  //   }
  // }

  Future<void> saveContractSample(String link) async {
    await _savePref(_contractSample, link);

    printLog("==============saveContact==========");
  }

  String? getContractSample() {
    return _getPref(_contractSample);
  }

  // UserModel? getUserModel() {
  //   String? user = _getPref(_userModel);
  //   if (user != null) {
  //     Map<String, dynamic> userMap = _decoder.convert(user);
  //     return UserModel.fromJson(userMap);
  //   } else {
  //     return null;
  //   }
  // }

  // RememberMeModel? getRememberMeModel() {
  //   String? user = _getPref(_rememberMeModel);
  //   if (user != null) {
  //     Map<String, dynamic> userMap = _decoder.convert(user);
  //     return RememberMeModel.fromJson(userMap);
  //   } else {
  //     return null;
  //   }
  // }

  // RememberMeModel? getRememberMeBussModel() {
  //   String? user = _getPref(_rememberMeBussModel);
  //   if (user != null) {
  //     Map<String, dynamic> userMap = _decoder.convert(user);
  //     return RememberMeModel.fromJson(userMap);
  //   } else {
  //     return null;
  //   }
  // }

  // Future<void> saveLanguage(TranslateModel model) async {
  //   printLog("model>>>${model.toJson()}");
  //   String value = _encoder.convert(model);
  //   final vv = await _savePref(_savedLanguage, value);
  //   printLog("SaveLanguage=============>>>>$vv");
  // }
  //
  // TranslateModel? getLanguage() {
  //   final jsonString = _getPref(_savedLanguage);
  //   if (jsonString == null) return null;
  //   Map<String, dynamic> data = _decoder.convert(jsonString);
  //   return TranslateModel.fromJson(data);
  // }
}
