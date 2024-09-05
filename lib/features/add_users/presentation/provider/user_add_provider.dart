import 'package:flutter/material.dart';
import 'package:task_sop/features/add_users/data/I_add_user_facade.dart';
import 'package:task_sop/general/widgets/toast_message.dart';

import '../../../../general/utils/appcolors.dart';
import '../../../home/data/model/user_model.dart';

class UserAddProvider extends ChangeNotifier {
  final IAddUserFacade addUserFacade;

  UserAddProvider({required this.addUserFacade});
  final  nameController = TextEditingController();
  final  ageController = TextEditingController();
  String imagePath = "";
  bool isLoading = false;

  // add users
  Future<void> addUser(UserModel user) async {
    final result = await addUserFacade.addUsers(user);
    result.fold((error) {
      ToastMessage.showMessage(
          "User Added Successfully", AppColors.styleBlueshade);
    }, (data) {
      ToastMessage.showMessage(" Successfully Added", AppColors.success);
    });
  }

  // user data from textfields
  void clearDatas() {
    nameController.clear();
    ageController.clear();
    imagePath = '';
    notifyListeners();
  }
}



