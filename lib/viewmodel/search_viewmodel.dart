
import 'package:flutter/material.dart';
import 'package:flutter_easy_http_api/api/api_call.dart';
import 'package:flutter_easy_http_api/model/enum.dart';
import 'package:flutter_easy_http_api/model/search_list_response.dart';
import 'package:flutter_easy_http_api/utils/common_util.dart';

import '../model/network_request_genric_response.dart';

class SearchViewModel extends ChangeNotifier {
  late ApiResponse<SearchListResponse> _searchListResponse;

  ApiResponse<SearchListResponse> get searchListResponse => _searchListResponse;



  SearchViewModel(){
    _searchListResponse=ApiResponse.noStatus("Welcome");
  }

  Future<void> getSearchList() async {
    CommonUtil().checkInternetConnection().then((value) async {
      if (value) {
        _searchListResponse = ApiResponse.loading("Loading");
        notifyListeners();

        try {
          var services = await APICall().getSearchList();
          _searchListResponse = ApiResponse.completed(services);
          notifyListeners();
        } catch (e) {
          _searchListResponse = ApiResponse.error(e.toString());
          notifyListeners();
        }
      } else {
        _searchListResponse = ApiResponse.noInternet("No Internet");
        notifyListeners();
      }
    });
  }
}
