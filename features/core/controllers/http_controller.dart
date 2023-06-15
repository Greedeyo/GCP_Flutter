import 'dart:io';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpController extends GetxController {
  Future getImagePredictionResults(File? file) async {
    const url = 'http://121.125.216.89:43210/';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile('file',
     file!.readAsBytes().asStream(), file!.lengthSync(),
     filename: file!.path.split("/").last));

    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);

    return resJson;
  }

  Future getPlantsShoppingListResults(String? string) async {
    const url = 'http://121.125.216.89:43210/product';
    final textStr = jsonEncode(toJson(string));
    final headers = {"Content-Type": "application/json"};

    final response = await http.post(Uri.parse(url), body: textStr, headers: headers);
    final result = jsonDecode(response.body);

    return(result);
  }

  toJson(String? string){
    return {
      "data": string,
    };
  }
}