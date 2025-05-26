import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService extends GetxService {
  static const String _tokenKey = 'auth_token';
  final RxnString token = RxnString();

  Future<TokenService> init() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString(_tokenKey);
    token.value = storedToken;

    // debugPrint(
    //   "TokenService init(): Loaded token from SharedPreferences: $storedToken."
    //       "Rx token.value is now: ${token.value}",
    // );

    return this;
  }

  Future<void> saveToken(String newToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, newToken);
    token.value = newToken;
   // debugPrint("Token saved to SharedPreferences: $newToken");
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    token.value = null;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  bool get isLoggedIn => token.value != null;
}
