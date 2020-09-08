import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:solu_bloc/config.dart';
import 'package:solu_bloc/helpers/auth_manager.dart';
import 'package:solu_bloc/utils/device_utils.dart';

class DioApi {
  Dio dio;

  DioApi(String apiUrl) {
    dio = Dio();
    dio.options.baseUrl = apiUrl;
    dio.interceptors.add(InterceptorsWrapper(onRequest: _requestIntercept));
    dio.interceptors.add(InterceptorsWrapper(onResponse: _responseIntercept));
    dio.interceptors.add(InterceptorsWrapper(onError: _errorIntercept));
  }

  _requestIntercept(RequestOptions options) async {
    /*if (authManager.isLoggedIn) {
      String token = authManager.accessToken;
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    String device = "${await deviceDetails()}";
    print("Authorization ${authManager.accessToken}");
    print("Is Logged in ${authManager.isLoggedIn}");
    if (options.data != null) {
      options.data["app_version"] = config.appVersion;
      options.data["device_info"] = "$device";
    }

    if (options.queryParameters != null) {
      options.queryParameters["app_version"] = config.appVersion;
    }*/

    print(
        "REQUEST: ${options.method}: ${options.baseUrl}${options.path} ${options.queryParameters}");
    print("BODY: ${json.encode(options.data)}");

    return options;
  }

  _responseIntercept(Response response) async {
    print("${response.request?.path} ${response.data}");
    return response;
  }

  _errorIntercept(DioError error) async {
    print("${error.request?.path} ${error.response?.data}");
    if (error.response?.statusCode == 401) {
      authManager.deactivated = true;
      await authManager.logout();
    }
    return error;
  }
}
