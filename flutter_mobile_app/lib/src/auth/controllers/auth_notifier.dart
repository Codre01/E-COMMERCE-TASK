import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/common/widgets/error_modal.dart';
import 'package:minified_commerce/src/auth/models/jwt_token_model.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void loginFunc(String data, BuildContext ctx) async {
    setLoading();
    try {
      var url = Uri.parse("http://127.0.0.1:8000/auth/jwt/create");
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json"
          },
          body: data);
      if (response.statusCode == 201) {
        final jwtToken = jwtTokenModelFromJson(response.body);

        Storage().setString("accessToken", jwtToken.access);
        Storage().setString("refreshToken", jwtToken.refresh);
        setLoading();
        ctx.go("/home");
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body);
        showErrorPopup(ctx, data['password'][0], null, null);
      }
    } catch (e) {
      setLoading();
      print(e);
      showErrorPopup(ctx, e.toString(), null, null);
    }
  }

  void registrationFunc(String data, BuildContext ctx) async {
    setLoading();
    try {
      var url = Uri.parse("${Environment.appBaseUrl}/auth/users/");
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json"
          },
          body: data);
      if (response.statusCode == 201) {
        setLoading();
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body);
        showErrorPopup(ctx, data['password'][0], null, null);
      }
    } catch (e) {
      setLoading();
      showErrorPopup(ctx, e.toString(), null, null);
    }
  }

  void getUser(String accessToken) async {
    try {
      var url = Uri.parse("${Environment.appBaseUrl}/auth/users/me/");
      var response = await http.get(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken"
          });
      if (response.statusCode == 200) {
        
      }
    } catch (e) {
      
    }
  }
}
