import 'package:emall/services/base_url/url_controller.dart';
import 'package:emall/services/web_service_components/api_base_helper.dart';

class ProductDetailsService {

  static final ApiBaseHelper _helper = ApiBaseHelper();

  static Future<dynamic> getProductDetails({required String productId}) async {

    dynamic response = await _helper.getRequest(UrlController().productUrl(productId));

    return response;
  }

  static Future<dynamic> getOnSaleProductDetails() async {

    dynamic response = await _helper.getRequest(UrlController().onSaleUrl());

    return response;
  }

}