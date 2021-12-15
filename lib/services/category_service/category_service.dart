import 'package:emall/services/base_url/url_controller.dart';
import 'package:emall/services/web_service_components/api_base_helper.dart';

class CategoryService {

  static final ApiBaseHelper _helper = ApiBaseHelper();

  static Future<dynamic> getCategoryList() async {

    dynamic response = await _helper.getRequest(UrlController().categoryListUrl());

    return response;
  }

  static Future<dynamic> getCategoryDetails(String categoryId) async {

    dynamic response = await _helper.getRequest(UrlController().categoryDetailsUrl(categoryId));

    return response;
  }

}