import 'package:flutter/material.dart';
import 'package:flutter_easy_http_api/model/enum.dart';
import 'package:flutter_easy_http_api/model/search_list_response.dart';
import 'package:flutter_easy_http_api/viewmodel/search_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SearchListResponse categoryListResponse;
  List<Results> categoryList = [];
  late SearchViewModel _searchViewModel;

  @override
  void initState() {
    // TODO: implement initState
    _searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    _searchViewModel.getSearchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<SearchViewModel>(builder: (context, item, child) {
        if (item.searchListResponse.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (item.searchListResponse.status == Status.success) {
          categoryList = item.searchListResponse.data!.results!;
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          Image.network(
                            categoryList[index].imageUrl.toString(),
                            height: 60,
                            width: 60,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              categoryList[index].title.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        } else if (item.searchListResponse.status == Status.noInternet) {
          return const Material(
            child: Center(
              child: Text('No internet Connection'),
            ),
          );
        }else if (item.searchListResponse.status == Status.none) {
          return const Material(
            child: Center(
              child: Text('Welcome'),
            ),
          );
        } else {
          return const Material(
            child: Center(
              child: Text('API Call Error'),
            ),
          );
        }
      }),
    );
  }
}
