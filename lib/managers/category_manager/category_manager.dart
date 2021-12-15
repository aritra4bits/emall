import 'package:emall/models/product_categories/category_details_model.dart';
import 'package:emall/models/product_categories/product_category_models.dart';
import 'package:emall/services/category_service/category_service.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:rxdart/rxdart.dart';


class CategoryListManager{

  final _categoryListController = BehaviorSubject<ApiResponse<CategoryIdListModel>?>();
  Stream<ApiResponse<CategoryIdListModel>?> get categoryList => _categoryListController.stream;

  final _categoryDetailsController = BehaviorSubject<ApiResponse<CategoryDetailsModel>?>();
  Stream<ApiResponse<CategoryDetailsModel>?> get categoryDetails => _categoryDetailsController.stream;

  Future<void> getCategoryList({bool withLoading = true}) async {
    if(withLoading) {
      _categoryListController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      result = await CategoryService.getCategoryList();
    }catch(e){
      AppUtils.showToast('Error: $e');
      _categoryListController.sink.add(null);
    }
    if (result != null){
      CategoryIdListModel categoryListResponse = CategoryIdListModel.fromJson(result);
      _categoryListController.sink.add(ApiResponse.completed(categoryListResponse));
    } else {
      _categoryListController.sink.add(ApiResponse.error("Server Error!"));
    }
  }

  Future<CategoryDetailsModel?> getCategoryDetails({required String categoryId, bool withLoading = true}) async {
    if(withLoading) {
      _categoryDetailsController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      result = await CategoryService.getCategoryDetails(categoryId);
    }catch(e){
      AppUtils.showToast('Error: $e');
      _categoryDetailsController.sink.add(null);
    }
    if (result != null){
      CategoryDetailsModel categoryDetailsResponse = CategoryDetailsModel.fromJson(result);
      _categoryDetailsController.sink.add(ApiResponse.completed(categoryDetailsResponse));
      return categoryDetailsResponse;
    } else {
      _categoryDetailsController.sink.add(ApiResponse.error("Server Error!"));
    }
  }

  dispose(){
    _categoryListController.close();
    _categoryDetailsController.close();
  }

  resetData(){
    _categoryListController.sink.add(null);
  }
}

final CategoryListManager categoryListManager = CategoryListManager();