import 'package:emall/services/base_url/url_controller.dart';
import 'package:emall/services/web_service_components/api_base_helper.dart';

class SearchService {

  static final ApiBaseHelper _helper = ApiBaseHelper();

  static Future<dynamic> searchProduct({required String searchTerm}) async {

    dynamic response = await _helper.getRequest(UrlController().searchUrl(searchTerm));

    return response;
  }

}