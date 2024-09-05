import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sop/general/core/di/typedef.dart';
import 'package:task_sop/general/core/main_faliures.dart';

abstract class AuthticationFacde {
   FutureResult signInWithGoogle() {
    throw UnimplementedError("signInWithGoogle() not implimetned");
  }

  Future<void> signOutUser() {
    throw UnimplementedError("signOutUser() not implimetned");
  }
}
