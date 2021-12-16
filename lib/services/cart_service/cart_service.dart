import 'dart:convert';

import 'package:emall/services/base_url/url_controller.dart';
import 'package:emall/services/web_service_components/api_base_helper.dart';

class CartService {

  static final ApiBaseHelper _helper = ApiBaseHelper();

  static Future<dynamic> createQuoteId() async {

    dynamic response = await _helper.postRequest(UrlController().createQuoteIdUrl(), null, setJsonHeader: false);

    return response;
  }

  static Future<dynamic> getCartItems(String cartId) async {

    dynamic response = await _helper.getRequest(UrlController().getCartItemsUrl(cartId));

    return response;
  }

  static Future<dynamic> addToCartId(String cartId, Map params) async {

    var httpBody = json.encode(params);

    dynamic response = await _helper.postRequest(UrlController().addToCartUrl(cartId), httpBody);

    return response;
  }

  static Future<dynamic> getCartTotal(String cartId) async {

    dynamic response = await _helper.getRequest(UrlController().getCartTotalUrl(cartId));

    return response;
  }

  static Future<dynamic> updateCartItem(String cartId, int? itemId, Map params) async {

    var httpBody = json.encode(params);

    dynamic response = await _helper.putRequest(UrlController().updateCartItemUrl(cartId, itemId), httpBody);

    return response;
  }

  static Future<dynamic> deleteCartItem(String cartId, int? itemId) async {

    dynamic response = await _helper.deleteRequest(UrlController().updateCartItemUrl(cartId, itemId));

    return response;
  }

  static Future<dynamic> addCoupon(String cartId, String coupon) async {

    dynamic response = await _helper.putRequest(UrlController().addCouponUrl(cartId, coupon), null);

    return response;
  }
}