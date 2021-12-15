import 'dart:io';
import 'package:emall/services/web_service_components/set_header.dart';
import 'package:emall/utils/app_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:http_parser/http_parser.dart';



class ApiBaseHelper {
  Future<dynamic> getRequest(String url) async {
    var responseJson;
    try {
      var header = await SetHeaderHttps.setHttpHeader();
      final response = await http.get(Uri.parse(url), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      AppUtils.showToast('Network error');
    }
    return responseJson;
  }

  Future<dynamic> postRequest(String url, dynamic body, {bool setJsonHeader = true}) async {
    var responseJson;
    try {
      var header = await SetHeaderHttps.setHttpHeader(setJsonHeader: setJsonHeader);
      final response = await http.post(Uri.parse(url), body: body, headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      AppUtils.showToast('Network error');
    }
    return responseJson;
  }

  Future<dynamic> uploadImage(String url, String key, List<File?> images, {Map<String, String?>? params}) async {

    var responseJson;
    var header = await SetHeaderHttps.setHttpHeader(uploadImage: true);
    var request = http.MultipartRequest('POST', Uri.parse(url));

    List<http.MultipartFile> newImageList = <http.MultipartFile>[];

    for (File? image in images){
      var multiPartFile = await http.MultipartFile.fromPath(key, image!.path, contentType: MediaType('image', 'jpeg'));
      newImageList.add(multiPartFile);
    }
    if(newImageList.isNotEmpty) {
      request.files.addAll(newImageList);
    }
    request.headers.addAll(header);
    if(params != null) {
      request.fields.addAll(params as Map<String, String>);
    }
    var res = await request.send();
    responseJson = _returnResponse(await http.Response.fromStream(res));
    return responseJson;
  }

  Future<dynamic> putRequest(String url, dynamic body) async {
    var responseJson;
    try {
      var header = await SetHeaderHttps.setHttpHeader();
      final response = await http.put(Uri.parse(url), body: body, headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      AppUtils.showToast('Network error');
    }
    return responseJson;
  }

  Future<dynamic> deleteRequest(String url) async {
    var apiResponse;
    try {
      var header = await SetHeaderHttps.setHttpHeader();
      final response = await http.delete(Uri.parse(url), headers: header);
      apiResponse = _returnResponse(response);
    } on SocketException {
      AppUtils.showToast('Network error');
    }
    return apiResponse;
  }

  dynamic _returnResponse(http.Response response) {
    print("Status Code = ${response.statusCode}");
    print("Body = ${response.body}");

    if(response.statusCode >= 200 && response.statusCode < 300){
      var responseJson;
      try{
        responseJson = json.decode(response.body);
      } catch(e){
        responseJson = response.body;
      }

      return responseJson;
    }
    else {
      AppUtils.showToast('Status Code: ${response.statusCode}\nBody: ${response.body}');
    }
  }
}
