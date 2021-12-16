import 'package:emall/config/preferences.dart';
import 'package:emall/models/cart/add_coupon_model.dart';
import 'package:emall/models/cart/add_to_cart_model.dart';
import 'package:emall/models/cart/cart_items_model.dart';
import 'package:emall/models/cart/cart_total_model.dart';
import 'package:emall/models/cart/update_cart_item.dart';
import 'package:emall/services/cart_service/cart_service.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:rxdart/rxdart.dart';


class CartManager{

  final _cartItemListController = BehaviorSubject<ApiResponse<CartItemsModel>?>();
  Stream<ApiResponse<CartItemsModel>?> get cartItemList => _cartItemListController.stream;

  final _cartTotalController = BehaviorSubject<ApiResponse<CartTotalModel>?>();
  Stream<ApiResponse<CartTotalModel>?> get cartTotal => _cartTotalController.stream;


  Future<void> getCartItemList({bool withLoading = true}) async {
    if(withLoading) {
      _cartItemListController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      String? quoteId = await preferences.getValueByKey(preferences.quoteId);
      if(quoteId != null){
        result = await CartService.getCartItems("mine");
        print("quoteId: $quoteId, result: $result");
      } else {
        int? quoteId = await createCartQuoteId();
        if(quoteId != null){
          result = await CartService.getCartItems("mine");
        } else {
          _cartItemListController.sink.add(ApiResponse.error("Unauthorized"));
          return;
        }
      }
    }catch(e){
      AppUtils.showToast('Error: $e');
      _cartItemListController.sink.add(null);
    }
    if (result != null){
      CartItemsModel cartItemListResponse = CartItemsModel.fromJson(result);
      _cartItemListController.sink.add(ApiResponse.completed(cartItemListResponse));
    } else {
      _cartItemListController.sink.add(ApiResponse.error("Server Error!"));
    }
  }

  Future<int?> createCartQuoteId() async {
    var result;
    try{
      result = await CartService.createQuoteId();
    }catch(e){
      AppUtils.showToast('Error: $e');
    }
    if (result != null && result is int){
      print("int value: $result");
      await preferences.setValueByKey(preferences.quoteId, result.toString());
      return result;
    } else if(result != null && result is Map<String, dynamic>){
      CartItemsModel cartItemListResponse = CartItemsModel.fromJson(result);
      print(cartItemListResponse.message);
      AppUtils.showToast(cartItemListResponse.message);
    } else {
      print('Failed to create cart id');
      AppUtils.showToast('Failed to create cart id');
    }
  }
  
  Future<AddToCartModel?> addToCart({required String sku, required int quantity}) async {
    var result;
    String? quoteId = await preferences.getValueByKey(preferences.quoteId);
    Map params = {
      "cart_item": {
        "quote_id": quoteId,
        "sku": sku,
        "qty": quantity
      }
    };
    try{
      if(quoteId != null) {
        result = await CartService.addToCartId("mine", params);
      } else {
        int? quoteId = await createCartQuoteId();
        if(quoteId != null){
          result = await CartService.addToCartId("mine", params);
        }
      }
    }catch(e){
      AppUtils.showToast('Error: $e');
    }
    if (result != null){
      AddToCartModel addToCartResponse = AddToCartModel.fromJson(result);
      return addToCartResponse;
    } else {
      AppUtils.showToast('Failed to add item to cart');
    }
  }

  Future<void> getCartTotal({bool withLoading = true}) async {
    if(withLoading) {
      _cartTotalController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      String? quoteId = await preferences.getValueByKey(preferences.quoteId);
      if(quoteId != null){
        result = await CartService.getCartTotal("mine");
      } else {
        int? quoteId = await createCartQuoteId();
        if(quoteId != null){
          result = await CartService.getCartTotal("mine");
        }
      }
    }catch(e){
      AppUtils.showToast('Error: $e');
      _cartTotalController.sink.add(null);
    }
    if (result != null){
      CartTotalModel cartTotalResponse = CartTotalModel.fromJson(result);
      _cartTotalController.sink.add(ApiResponse.completed(cartTotalResponse));
    } else {
      _cartTotalController.sink.add(ApiResponse.error("Server Error!"));
    }
  }

  Future<UpdateCartItemModel?> updateCartItem({required int? itemId, required int quantity}) async {
    var result;
    String? quoteId = await preferences.getValueByKey(preferences.quoteId);
    Map params = {
      "cart_item": {
        "quote_id": quoteId,
        "item_id": itemId,
        "qty": quantity
      }
    };

    try{
      if(quoteId != null) {
        result = await CartService.updateCartItem("mine", itemId, params);
      }
    }catch(e){
      AppUtils.showToast('Error: $e');
    }
    if (result != null){
      UpdateCartItemModel updateCartResponse = UpdateCartItemModel.fromJson(result);
      if(updateCartResponse.qty != null){
        getCartItemList(withLoading: false);
        getCartTotal(withLoading: false);
      }
      return updateCartResponse;
    } else {
      AppUtils.showToast('Failed to update item quantity');
    }
  }

  Future<bool?> deleteCartItem({required int? itemId}) async {
    var result;
    try{
      result = await CartService.deleteCartItem("mine", itemId);
    }catch(e){
      AppUtils.showToast('Error: $e');
      return false;
    }
    if (result != null && result == true){
      getCartItemList(withLoading: false);
      getCartTotal(withLoading: false);
      return true;
    } else {
      AppUtils.showToast('Failed to add item to cart');
      return false;
    }
  }

  Future<AddCouponModel?> addCoupon({required String coupon, required int quantity}) async {
    var result;
    String? cartId = await preferences.getValueByKey(preferences.quoteId);

    try{
      if(cartId != null) {
        result = await CartService.addCoupon(cartId, coupon);
      }
    }catch(e){
      AppUtils.showToast('Error: $e');
    }
    if (result != null){
      AddCouponModel addCouponResponse = AddCouponModel.fromJson(result);
      AppUtils.showToast(addCouponResponse.message??"");
      return addCouponResponse;
    } else {
      AppUtils.showToast('Failed to add coupon to cart');
    }
  }

  dispose(){
    _cartItemListController.close();
  }

  resetData(){
    _cartItemListController.sink.add(null);
  }
}

final CartManager cartManager = CartManager();