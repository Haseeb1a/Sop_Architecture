// import 'package:sop_artitecture/features/home/data/i_home_facade.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_sop/features/home/data/model/user_model.dart';
import 'package:task_sop/general/core/age_type.dart';
import 'package:task_sop/general/core/di/typedef.dart';
import 'package:task_sop/general/utils/firebase_collection.dart';

import '../../../general/core/main_faliures.dart';
import '../data/i_home_facade.dart';

@LazySingleton(as: IHomeFacade)
class IHomeRepositoriy implements IHomeFacade {
  final FirebaseFirestore firestore;

  IHomeRepositoriy({required this.firestore});
  QueryDocumentSnapshot? lastDocs;
  // get users for the firebase
  @override
  FutureResult<List<UserModel>> getusers(AgeType ageType) async {
    try {
      QuerySnapshot<Map<String, dynamic>>? ref;
      if (AgeType.all == ageType) {
        ref = (lastDocs == null)
            ? await firestore
                .collection(FirebaseCollection.users)
                .orderBy("timestamp", descending: true)
                .limit(7)
                .get()
            : await firestore
                .collection(FirebaseCollection.users)
                .orderBy("timestamp", descending: true)
                .startAfterDocument(lastDocs!)
                .limit(7)
                .get();
      } else if (AgeType.younger == ageType) {
        ref = (lastDocs == null)
            ? await firestore
                .collection(FirebaseCollection.users)
                .where('age', isLessThan: 60)
                .orderBy('age', descending: false)
                .limit(7)
                .get()
            : await firestore
                .collection(FirebaseCollection.users)
                .where('age', isLessThan: 60)
                .orderBy('age', descending: false)
                .startAfterDocument(lastDocs!)
                .limit(7)
                .get();
      } else {
        ref = (lastDocs == null)
            ? await firestore
                .collection(FirebaseCollection.users)
                .where('age', isGreaterThanOrEqualTo: 60)
                .orderBy('age', descending: false)
                .limit(7)
                .get()
            : await firestore
                .collection(FirebaseCollection.users)
                .where('age', isGreaterThanOrEqualTo: 60)
                .orderBy('age', descending: false)
                .startAfterDocument(lastDocs!)
                .limit(7)
                .get();
      }
      if (ref.docs.isEmpty) {
        return left(
          const MainFailure.serverFailure(
            errorMsg: 'No More Data',
          ),
        );
      } else {
        lastDocs = ref.docs.last;
        return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
      }
    } catch (e) {
      return left(
        MainFailure.serverFailure(
          errorMsg: e.toString(),
        ),
      );
    }
  }

  @override
  void cleardata() {
    lastDocs = null;

  }
}
