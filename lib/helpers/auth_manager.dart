import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:prefs/prefs.dart';
import 'package:solu_bloc/api/api.dart';
import 'package:solu_bloc/data/models/auth_data.dart';
import 'package:solu_bloc/data/models/user.dart';
import 'package:solu_bloc/tools/manager.dart';

class AuthManager extends Manager {
  User get user {
    String _user = Prefs?.getString("user") ?? null;
    if (_user == null) return null;
    return User.fromMap(json.decode(_user));
  }

  bool _deactivated = true;
  bool get deactivated => _deactivated;

  set deactivated(value) {
    _deactivated = value;
    notifyChanges();
  }

  String resetCode;
  String resetPhoneNumber;
  String emailAddress;

  String get accessToken => Prefs?.getString("accessToken");

  bool get isLoggedIn {
    return (user != null && accessToken != null) ? true : false;
  }

  AuthData get authData {
    return AuthData(
      user: user,
      accessToken: accessToken,
    );
  }

  Future<bool> setUser(User user) async {
    return await Prefs?.setString("user", json.encode(user.toMap()));
  }

  Future<bool> setAccessToken(String token) async {
    return await Prefs?.setString("accessToken", token);
  }

  Future<bool> setAuthData(AuthData authData) async {
    print("AuthData ${authData.toMap()}");
    return (await setAccessToken(authData.accessToken) &&
        await setUser(authData.user));
  }

  Future<bool> logout() async {
    notifyChanges();
    return (await Prefs.remove("user") && await Prefs.remove("accessToken"));
  }

  Future login({
    String email,
    String password,
  }) async {
    return api
        .login(email, password)
        .then(_onLoginResponse)
        .catchError(_onLoginError);
  }

  Future recover({
    String email,
  }) async {
    emailAddress = email;
    return api
        .recoverPassword(email)
        .then(_onRecoverResponse)
        .catchError(_onRecoverError);
  }

  Future reset({
    String password,
  }) async {
    return api
        .resetPassword(emailAddress, password, resetCode)
        .then(_onRecoverResponse)
        .catchError(_onRecoverError);
  }

  _onLoginResponse(response) async {
    if (response.data["status"] != 1) {
      throw DioError(response: response);
    }
    var payload = response.data["payload"];
    await authManager.setAuthData(AuthData.fromMap(payload));
    return response;
  }

  _onLoginError(error) async {
    return throw error;
  }

  _onRecoverResponse(response) async {
    if (response.data["status"] != "success") {
      throw DioError(response: response);
    }
    resetCode = "${response.data["code"]}";
    resetPhoneNumber = response.data["phone_number"];
    return response;
  }

  _onRecoverError(error) async {
    return throw error;
  }
}

var authManager = AuthManager();
