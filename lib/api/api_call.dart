import 'package:flutter_easy_http_api/constant/api_const.dart';
import '../model/search_list_response.dart';
import '../network/api_base_helper.dart';

class APICall {


  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<SearchListResponse> getSearchList() async {

    var responseBody=  await _helper.get(APIConst.searchQuery);
    return SearchListResponse.fromJson(responseBody);
  }
}
