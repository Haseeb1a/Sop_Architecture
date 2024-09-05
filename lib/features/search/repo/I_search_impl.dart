import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_sop/general/core/age_type.dart';
import 'package:task_sop/general/core/di/typedef.dart';
import 'package:task_sop/general/core/main_faliures.dart';

import '../../../general/utils/firebase_collection.dart';
import '../../home/data/model/user_model.dart';
import '../data/I_search_facade.dart';

@LazySingleton(as: ISearchFacade)
class Searchrepostory implements ISearchFacade {
  QueryDocumentSnapshot? lastDocs;

  @override
  FutureResult<List<UserModel>> getSearchResults(String searchname) async {
    try {
      QuerySnapshot<Map<String, dynamic>>? ref;
      ref = (lastDocs == null)
          ? await FirebaseFirestore.instance
              .collection(FirebaseCollection.users)
              .where('search',
                  arrayContains: searchname.toLowerCase().replaceAll(' ', ''))
              .orderBy('timestamp', descending: true)
              .limit(7) //get initial limited users from firestore
              .get()
          : await FirebaseFirestore.instance
              .collection(FirebaseCollection.users)
              .where('search',
                  arrayContains: searchname.toLowerCase().replaceAll(' ', ''))
              .orderBy('timestamp', descending: true)
              .startAfterDocument(lastDocs!)
              .limit(7) //get more users from firestore
              .get();
      if (ref.docs.isEmpty) {
        return left(const MainFailure.dataNotFount(errorMsg: 'no Data avalable'));
      } else {
        lastDocs = ref.docs.last;
        return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
      }
    } catch (e) {
      log(e.toString());
      return left(
          const MainFailure.dataNotFount(errorMsg: 'search data no availabe'));
    }
  }
}
