import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_sop/general/utils/appcolors.dart';
import 'package:task_sop/general/widgets/toast_message.dart';

import '../../../home/presentation/view/screens/home_page.dart';
import '../../data/i_auth_facade.dart';

class AuthProvider extends ChangeNotifier {
  final AuthticationFacde authticationFacde;

  AuthProvider({required this.authticationFacde});

//  Sign--With google---
  void loginWithGoogleSingUP(
      {required void Function() successgoogleAuth,
      required void Function(String) authfailure}) async {
    final authuser = await authticationFacde.signInWithGoogle();
    authuser.fold((error) {
      authfailure.call(error.errorMsg);
    }, (data) {
      ToastMessage.showMessage("login Successfully", AppColors.styleBlueshade);
      successgoogleAuth.call();
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const HomeScreen(),
      //     ));
      // notifyListeners();
    });
    notifyListeners();
  }

  // signOut
  Future<void> signOut() async {
    try {
      await authticationFacde.signOutUser();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
