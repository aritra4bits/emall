import 'package:emall/config/global.dart';
import 'package:emall/config/preferences.dart';
import 'package:emall/models/user_model/user_model.dart';
import 'package:emall/services/auth_service/auth_service.dart';
import 'package:emall/services/web_service_components/api_response.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:rxdart/rxdart.dart';


class AuthManager{

  final _customerDetailsController = BehaviorSubject<ApiResponse<Customer>?>();
  Stream<ApiResponse<Customer>?> get customerData => _customerDetailsController.stream;


  Future<bool?> registerUser({bool withLoading = true, required Map params}) async {
    if(withLoading) {
      _customerDetailsController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      result = await AuthService.registerUser(params);
    }catch(e){
      AppUtils.showToast('Error: $e');
      _customerDetailsController.sink.add(null);
      return false;
    }
    if (result != null){
      Customer registerResponse = Customer.fromJson(result);
      _customerDetailsController.sink.add(ApiResponse.completed(registerResponse));
      if(registerResponse.id != null){
        return true;
      } else {
        return false;
      }
    } else {
      _customerDetailsController.sink.add(ApiResponse.error("Server Error!"));
      return false;
    }
  }

  Future<bool?> loginUser({required Map params}) async {
    var result;
    try{
      result = await AuthService.loginUser(params);
    }catch(e){
      AppUtils.showToast('Error: $e');
      return false;
    }
    if (result != null && result is String){
      print(result);
      ApplicationGlobal.bearerToken = result;
      await preferences.setValueByKey(preferences.bearerToken, result);
      getUser();
      return true;
    } else {
      AppUtils.showToast('Failed to login user');
      return false;
    }
  }

  Future<bool?> resetPassword({required Map params}) async {
    var result;
    try{
      result = await AuthService.resetPassword(params);
    }catch(e){
      AppUtils.showToast('Error: $e');
      return false;
    }
    if (result != null && result is bool){
      print(result);
      return result;
    } else {
      AppUtils.showToast('Failed to send reset password link');
      return false;
    }
  }

  Future<void> getUser({bool withLoading = true}) async {
    if(withLoading) {
      _customerDetailsController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      result = await AuthService.getUserDetails();
    }catch(e){
      AppUtils.showToast('Error: $e');
      _customerDetailsController.sink.add(null);
    }
    if (result != null){
      Customer getUserResponse = Customer.fromJson(result);
      if(getUserResponse.id != null){
        _customerDetailsController.sink.add(ApiResponse.completed(getUserResponse));
      } else if(getUserResponse.message != null){
        _customerDetailsController.sink.add(ApiResponse.error(getUserResponse.message));
      }
    } else {
      _customerDetailsController.sink.add(ApiResponse.error("Server Error!"));
    }
  }

  Customer? getUserDetails(){
    return _customerDetailsController.value?.data;
  }

  Future<Customer?> updateUser({required Map params, bool withLoading = true}) async {
    if(withLoading) {
      _customerDetailsController.sink.add(ApiResponse.loading("In Progress"));
    }
    var result;
    try{
      result = await AuthService.updateUserDetails(params);
    }catch(e){
      AppUtils.showToast('Error: $e');
      _customerDetailsController.sink.add(null);
    }
    if (result != null){
      Customer getUserResponse = Customer.fromJson(result);
      _customerDetailsController.sink.add(ApiResponse.completed(getUserResponse));
      return getUserResponse;
    } else {
      _customerDetailsController.sink.add(ApiResponse.error("Server Error!"));
    }
  }



  dispose(){
    _customerDetailsController.close();
  }

  resetData(){
    _customerDetailsController.sink.add(null);
  }
}

final AuthManager authManager = AuthManager();