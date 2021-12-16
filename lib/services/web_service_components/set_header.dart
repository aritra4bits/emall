
import 'package:emall/config/global.dart';

class SetHeaderHttps {
  static Future<Map<String, String>> setHttpHeader({bool uploadImage=false, bool setJsonHeader = true}) async {
    var authToken = ApplicationGlobal.bearerToken.isNotEmpty ? "Bearer ${ApplicationGlobal.bearerToken}" : "";

    Map<String, String> header;
    if(uploadImage){
      header = {
        'Content-type': 'multipart/form-data',
        'Accept': 'application/json',
        "Authorization": authToken
      };
    }else{
      if(setJsonHeader){
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": authToken
        };
      } else {
        header = {
          "Authorization": authToken
        };
      }
    }
    return header;
  }
}
