import 'package:emall/services/base_url/url_controller.dart';
import 'package:emall/services/web_service_components/api_base_helper.dart';

class CartService {

  static final ApiBaseHelper _helper = ApiBaseHelper();

  static Future<dynamic> createCartId() async {

    dynamic response = await _helper.postRequest(UrlController().createCartIdUrl(), null, setJsonHeader: false);

    return response;
  }

  static Future<dynamic> getCartItems(String cartId) async {

    dynamic response = await _helper.getRequest(UrlController().getCartItemsUrl(cartId));

    return response;
  }

}