import 'dart:convert';

import 'package:emall/services/base_url/url_controller.dart';
import 'package:emall/services/web_service_components/api_base_helper.dart';

class AuthService {

  static final ApiBaseHelper _helper = ApiBaseHelper();

  static Future<dynamic> registerUser(Map params) async {
    var httpBody = json.encode(params);
    dynamic response = await _helper.postRequest(UrlController().registerUserUrl(), httpBody);
    return response;
  }

  static Future<dynamic> loginUser(Map params) async {
    var httpBody = json.encode(params);
    dynamic response = await _helper.postRequest(UrlController().loginUserUrl(), httpBody);
    return response;
  }

  static Future<dynamic> getUserDetails() async {
    dynamic response = await _helper.getRequest(UrlController().userDetailsUrl());
    return response;
  }

  static Future<dynamic> updateUserDetails(Map params) async {
    var httpBody = json.encode(params);
    dynamic response = await _helper.putRequest(UrlController().userDetailsUrl(), httpBody);
    return response;
  }

}