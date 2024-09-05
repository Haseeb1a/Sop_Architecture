import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:task_sop/features/home/presentation/view/screens/home_page.dart';
import 'package:task_sop/general/utils/appcolors.dart';

import '../../../general/core/main_faliures.dart';
import '../../../general/widgets/toast_message.dart';
import '../data/i_auth_facade.dart';

@LazySingleton(as: AuthticationFacde)
class IAuthticationReprository implements AuthticationFacde {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  IAuthticationReprository(
      {required this.firestore, required this.firebaseAuth,required this.googleSignIn});


  // SingUp user Google------
  @override
  Future<Either<MainFailure, String>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);
      // Once signed in, return the UserCredential
      return right('Authentication Success');
    } catch (e) {
      log('\nsignInWithGooglepp $e');
      ToastMessage.showMessage('$e', AppColors.error);
      // Dialogs(contex, 'something  Went wrong (Check Inernet)');
      return left(MainFailure.authenticationFailure(errorMsg: e.toString()));
    }
  }

  //signOut from the app
  @override
  Future<void> signOutUser() async {
    try {
      await GoogleSignIn().signOut();
      await firebaseAuth.signOut();
    } catch (e) {
      ToastMessage.showMessage('fkjsh$e', AppColors.error);
      log('\n signOut  Failed: $e');
    }
  }
}

  // @override
  //   Future<void> otpVerification(String otp, String verificationId) {
  //   try {
  //     AuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: otp);
  //   } catch (e) {

  //   }
  // }

// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:totalxrecriation/view/auth_screen/auth_page.dart';
// import 'package:totalxrecriation/view/home_page/home_page.dart';

// import '../contrants/toast_message.dart';

// class AuthServices {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final firebaseAuth = FirebaseAuth.instance;

//   //login to the app using phone number
//   Future<UserCredential?> signInWithGoogle(contex) async {
//     try {
//       // Trigger the authentication flow

//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//       Navigator.push(
//           contex,
//           MaterialPageRoute(
//             builder: (context) => Homepage(),
//           ));
//       // Once signed in, return the UserCredential
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } catch (e) {
//       log('\nsignInWithGooglepp $e');
//       ToastMessage.showMessage('$e', Color.fromARGB(0, 255, 0, 0));
//       // Dialogs(contex, 'something  Went wrong (Check Inernet)');
//       return null;
//     }
//   }

//   //signOut from the app
//   Future<void> signOutUser() async {
//     try {
//       await GoogleSignIn().signOut();
//       await firebaseAuth.signOut();
   
//     } catch (e) {
//       ToastMessage.showMessage('fkjsh$e', Color.fromARGB(0, 86, 86, 255));
//       log('\n signOut  Failed: $e');
//     }
//   }
// }
