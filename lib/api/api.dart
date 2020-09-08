import 'dart:convert';

import 'package:solu_bloc/api/dio_api.dart';
import 'package:solu_bloc/config.dart';
import 'package:solu_bloc/helpers/auth_manager.dart';
import 'package:solu_bloc/utils/format_utils.dart';

class Api extends DioApi {
  Api(String apiUrl) : super(apiUrl);

  Future login(String email, String password) {
    return dio.post("/login", data: {
      "email": email,
      "password": password,
    });
  }

  Future recoverPassword(String email) {
    return dio.post("/v1/recover", data: {
      "email": email,
    });
  }

  Future getTodos() {
    return dio.get("/todos");
  }

  Future resetPassword(
    String email,
    String password,
    String code,
  ) {
    return dio.post("/v1/reset", data: {
      "email": email,
      "password": password,
      "code": code,
    });
  }
}

Api api = Api(config.apiUrl);
