import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:task_sop/features/add_users/data/I_add_user_facade.dart';
import 'package:task_sop/features/home/data/model/user_model.dart';
import 'package:task_sop/general/core/main_faliures.dart';
import 'package:task_sop/general/utils/firebase_collection.dart';

import '../../../general/core/di/typedef.dart';

@LazySingleton(as: IAddUserFacade)
class AddUserReposetorty implements IAddUserFacade {
  final FirebaseFirestore firestore;
  AddUserReposetorty({required this.firestore});

  // add new users to the firebaser
  @override
  FutureResult<Unit> addUsers(UserModel user) async {
    try {
      final id = firestore.collection(FirebaseCollection.users).doc().id;
      await firestore.collection(FirebaseCollection.users).doc(id).set(
            user.toMap(),
          );
      return right(unit);
    } catch (e) {
      log(
        e.toString(),
      );
      return left(
        MainFailure.addsuerFailure(
          errorMsg: e.toString(),
        ),
      );
    }
  }

  
}
