import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'app_exceptions.dart';

class ApiBaseHelper {


  final String _baseUrl="https://api.jikan.moe/v3/search/";

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }



  Future<dynamic> post(String url,dynamic body) async {
    dynamic responseJson;
   var  headers= <String, String>{
      'Content-Type': 'application/json'
    };
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),headers:headers,body: json.encode(body) );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithHeaderToken(String url,dynamic body,String token) async {

    dynamic responseJson;
    var  headers= <String, String>{
      'Content-Type': 'application/json',
      "x-token": token
    };
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),headers:headers,body: json.encode(body) );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }




  Future<dynamic> put(String url,dynamic body) async {
    dynamic responseJson;
    var  headers= <String, String>{
      'Content-Type': 'application/json',
      "Access-Control_Allow_Origin": "*"
    };
    try {
      final response = await http.put(Uri.parse(_baseUrl + url),body: json.encode(body),headers: headers );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}