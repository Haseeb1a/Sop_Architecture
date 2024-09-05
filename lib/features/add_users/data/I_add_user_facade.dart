import 'package:dartz/dartz.dart';
import 'package:task_sop/features/home/data/model/user_model.dart';

import '../../../general/core/di/typedef.dart';

abstract class IAddUserFacade {
  FutureResult<Unit> addUsers(UserModel user) async {
    throw UnimplementedError('addUsers() not implimented');
  }
}
