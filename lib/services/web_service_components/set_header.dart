
class SetHeaderHttps {
  static Future<Map<String, String>> setHttpHeader({bool uploadImage=false, bool setJsonHeader = true}) async {
    var authToken = "";

    Map<String, String> header;
    if(uploadImage){
      if(setJsonHeader){
        header = {
          'Content-type': 'multipart/form-data',
          'Accept': 'application/json',
          "Authorization": authToken
        };
      } else {
        header = {};
      }

    }else{
      header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": authToken
      };
    }
    return header;
  }
}
