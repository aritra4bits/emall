import 'package:emall/config/preferences.dart';
import 'package:emall/models/cart/cart_items_model.dart';
import 'package:emall/services/cart_service/cart_service.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:rxdart/rxdart.dart';


class CartManager{

  final _cartItemListController = BehaviorSubject<ApiResponse<CartItemsModel>?>();
  Stream<ApiResponse<CartItemsModel>?> get cartItemList => _cartItemListController.stream;


  Future<void> getCartItemList({bool withLoading = true}) async {
    if(withLoading) {
      _cartItemListController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      String? cartId = await preferences.getValueByKey(preferences.cartId);
      if(cartId != null){
        print(cartId);
        result = await CartService.getCartItems(cartId);
      } else {
        String? cartId = await createCartId();
        if(cartId != null){
          result = await CartService.getCartItems(cartId);
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

  Future<String?> createCartId() async {
    var result;
    try{
      result = await CartService.createCartId();
    }catch(e){
      AppUtils.showToast('Error: $e');
    }
    if (result != null){
      print("$result");
      await preferences.setValueByKey(preferences.cartId, result);
      return result;
    } else {
      AppUtils.showToast('Failed to create cart id');
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