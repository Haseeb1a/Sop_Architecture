import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_sop/general/widgets/toast_message.dart';

// import '../../data/i_auth_facade.dart';
import '../../../../general/core/age_type.dart';
import '../../data/i_home_facade.dart';
import '../../data/model/user_model.dart';

class HomeProvider extends ChangeNotifier {
  final IHomeFacade homeFacade;

  HomeProvider({required this.homeFacade});

  AgeType selectedValue = AgeType.all;
  ScrollController scrollController = ScrollController();
  bool isMoreDataLoading = true;
  bool isLoading = false;
  List<UserModel> usersList = [];

  // inital fucntion--------
  void init() {
    if (usersList.isEmpty) {
      getUsers(selectedValue);
      notifyListeners();
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getUsers(selectedValue);
      }
    });
  }

//  get users
  Future<void> getUsers(AgeType ageType) async {
    isLoading = true;
    final userdata = await homeFacade.getusers(ageType);
    userdata.fold((error) {
      log(error.errorMsg);
      if (error.errorMsg == 'No More Data') {
        isMoreDataLoading = false;
        ToastMessage.showMessage(error.errorMsg, Colors.red);
        notifyListeners();
      } else {
        isMoreDataLoading = false;
        notifyListeners();
      }
    }, (data) {
      if (data.length != 7) {
        isMoreDataLoading = false;
        log(isMoreDataLoading.toString()); //dd-----------
      }
      log(isMoreDataLoading.toString());
      usersList = [...usersList, ...data];
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
  }

  changeValue(AgeType value) {
    selectedValue = value;
    log(value.toString());
    notifyListeners();
  }
  //add user user localy
  void addUserLocaly(UserModel userData) {
    usersList.insert(0, userData);
    notifyListeners();
  }

  void clearData() {
    isMoreDataLoading = true;
    usersList.clear();
    homeFacade.cleardata();
    notifyListeners();
  }
}
