import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../general/widgets/toast_message.dart';
import '../../../home/data/model/user_model.dart';

class SearchProvider extends ChangeNotifier {
  final ISearchFacade;
  SearchProvider({required this.ISearchFacade});

  final searchController = TextEditingController();
 List<UserModel> userSearchList = [];

  final ScrollController scrollController = ScrollController();
  bool isMoreDataLoading = true;
  bool isLoading = false;

   // inital fucntion--------
  void init() {
    if (userSearchList.isEmpty) {
      getSearchUsers();
      notifyListeners();
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
            getSearchUsers();
      }
    });
  }

   //Get Search Users Data
  Future<void> getSearchUsers() async {
    isLoading = true;
    final data = await ISearchFacade
        .getSearchResults(searchController.text.trim());
    data.fold((error) {
      log(error.toString());
      if (error == 'No User Found') {
        isMoreDataLoading = false; // 
        ToastMessage.showMessage(error, Colors.red);
        notifyListeners();
      } else {
        isMoreDataLoading = false;
        notifyListeners();
      }
    }, (data) {
      if (data.length != 7) {
        isMoreDataLoading = false;
        log(isMoreDataLoading.toString());
      }
      log(isMoreDataLoading.toString());
      userSearchList = [...userSearchList, ...data];
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
  }

  // clear previous search history
  void clearData() {
    ISearchFacade.lastDocs = null;
    isMoreDataLoading = true;
    userSearchList.clear();
    notifyListeners();
  }
}
