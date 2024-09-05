import '../../../general/core/di/typedef.dart';
import '../../home/data/model/user_model.dart';

abstract class ISearchFacade {
  FutureResult<List<UserModel>> getSearchResults(String searchname) async {
    throw UnimplementedError('getSearchResults() not implemented');
  }
}
