import 'package:emall/models/product_model/product_model.dart';
import 'package:emall/services/product_details_service/product_details_service.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:rxdart/rxdart.dart';


class ProductDetailsManager{

  final _productsDetailsController = BehaviorSubject<ApiResponse<ProductModel>?>();
  Stream<ApiResponse<ProductModel>?> get productList => _productsDetailsController.stream;

  Future<void> getProducts({required String productId, bool withLoading = true}) async {
    if(withLoading) {
      _productsDetailsController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      result = await ProductDetailsService.getProductDetails(productId: productId);
    }catch(e){
      AppUtils.showToast('Error: $e');
      _productsDetailsController.sink.add(null);
    }
    if (result != null){
      ProductModel productsResult = ProductModel.fromJson(result);
      _productsDetailsController.sink.add(ApiResponse.completed(productsResult));
    } else {
      _productsDetailsController.sink.add(ApiResponse.error("Server Error!"));
    }
  }

  dispose(){
    _productsDetailsController.close();
  }

  resetData(){
    _productsDetailsController.sink.add(null);
  }
}

final ProductDetailsManager productDetailsManager = ProductDetailsManager();