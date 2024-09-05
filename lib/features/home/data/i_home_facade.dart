
import 'package:task_sop/features/home/data/model/user_model.dart';

import '../../../general/core/age_type.dart';
import '../../../general/core/di/typedef.dart';
import '../../../general/core/main_faliures.dart';

abstract class IHomeFacade {

 FutureResult<List<UserModel>> getusers(AgeType type) async{

    throw UnimplementedError('fetch() not implimented');
  }
  

 void cleardata(){
  throw UnimplementedError('cleardata() not implimented');
  }
}
