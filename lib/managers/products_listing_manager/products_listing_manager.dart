import 'package:emall/models/product_model/product_model.dart';
import 'package:emall/services/product_details_service/product_details_service.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:rxdart/rxdart.dart';


class ProductsListingManager{

  final _onSaleProductsListingController = BehaviorSubject<ApiResponse<ProductModel>?>();
  Stream<ApiResponse<ProductModel>?> get onSaleProductList => _onSaleProductsListingController.stream;

  Future<void> getOnSaleProducts({bool withLoading = true}) async {
    if(withLoading) {
      _onSaleProductsListingController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      result = await ProductDetailsService.getOnSaleProductDetails();
    }catch(e){
      AppUtils.showToast('Error: $e');
      _onSaleProductsListingController.sink.add(null);
    }
    if (result != null){
      ProductModel productsResult = ProductModel.fromJson(result);
      _onSaleProductsListingController.sink.add(ApiResponse.completed(productsResult));
    } else {
      _onSaleProductsListingController.sink.add(ApiResponse.error("Server Error!"));
    }
  }

  dispose(){
    _onSaleProductsListingController.close();
  }

  resetData(){
    _onSaleProductsListingController.sink.add(null);
  }
}

final ProductsListingManager productsListingManager = ProductsListingManager();