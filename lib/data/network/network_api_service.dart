

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

import '../app_exceptions.dart';
import 'base_api_service.dart';

class NetworkApiResponse extends BaseApiService{
  @override
  Future getGetApiResponse(Uri url)async {
    dynamic responseJson;
    try{
      final response = await http.get(url).timeout(Duration(seconds: 10));
      responseJson=returnResponse(response);
    }on SocketException{
      throw fetchDataException('no internet connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(Uri uri, { required dynamic body}) async {
    dynamic responseJson;
    try {
      Response response = await post(
          Uri.parse(uri.toString()),
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"}
      ).timeout(Duration(seconds: 10));
      responseJson=returnResponse(response);

    } on SocketException {
      throw fetchDataException('no internet connection');
    }
    log(responseJson.toString());
    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson= jsonDecode(response.body);
        log("hello"+responseJson.toString());
        return responseJson;
      case 400:
        return throw badRequestException();
      case 404:
        return throw failedtoFetchException(response.body.toString());
      case 201:
        dynamic responseJson= jsonDecode(response.body);
        return responseJson;
      case 500:
        return throw fetchDataException();
      default:
        return fetchDataException('error occur while commmunicating with server'+'with status code:'+response.statusCode.toString());

    }
  }

  @override
  Future getGetApiResponsebyDio(String url, data) {
    // TODO: implement getGetApiResponsebyDio
    throw UnimplementedError();
  }

}

