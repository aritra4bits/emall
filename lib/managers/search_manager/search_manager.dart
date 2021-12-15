import 'package:emall/managers/product_details_manager/product_details_manager.dart';
import 'package:emall/models/search_model/search_model.dart';
import 'package:emall/services/search_service/search_service.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:rxdart/rxdart.dart';


class SearchManager{

  final _searchController = BehaviorSubject<ApiResponse<SearchModel>?>();
  Stream<ApiResponse<SearchModel>?> get searchData => _searchController.stream;

  Future<void> searchProduct({required String searchTerm, bool withLoading = true}) async {
    if(withLoading) {
      _searchController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      result = await SearchService.searchProduct(searchTerm: searchTerm);
    }catch(e){
      AppUtils.showToast('Error: $e');
      _searchController.sink.add(null);
    }
    if (result != null){
      SearchModel searchResult = SearchModel.fromJson(result);
      if(searchResult.items != null){
        List<int?> productIds = searchResult.items!.map((e) => e.id).toList();
        productDetailsManager.getProducts(productId: productIds.join(","));
      }
      _searchController.sink.add(ApiResponse.completed(searchResult));
    } else {
      _searchController.sink.add(ApiResponse.error("Server Error!"));
    }
  }

  dispose(){
    _searchController.close();
  }

  resetData(){
    _searchController.sink.add(null);
  }
}

final SearchManager searchManager = SearchManager();