// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../../features/add_users/data/I_add_user_facade.dart' as _i640;
import '../../../features/add_users/repo/I_add_user_impl.dart' as _i575;
import '../../../features/authentication/data/i_auth_facade.dart' as _i518;
import '../../../features/authentication/repo/i_authtication_reprository.dart'
    as _i958;
import '../../../features/home/data/i_home_facade.dart' as _i207;
import '../../../features/home/repo/i_home_impl.dart' as _i269;
import '../../../features/search/data/I_search_facade.dart' as _i683;
import '../../../features/search/repo/I_search_impl.dart' as _i1060;
import 'firebase_injection.dart' as _i99;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  await gh.factoryAsync<_i99.FirebaseServeice>(
    () => firebaseInjectableModule.firebaseServeice,
    preResolve: true,
  );
  gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i59.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i457.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.lazySingleton<_i116.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<_i683.ISearchFacade>(() => _i1060.Searchrepostory());
  gh.lazySingleton<_i207.IHomeFacade>(
      () => _i269.IHomeRepositoriy(firestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i640.IAddUserFacade>(
      () => _i575.AddUserReposetorty(firestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i518.AuthticationFacde>(
      () => _i958.IAuthticationReprository(
            firestore: gh<_i974.FirebaseFirestore>(),
            firebaseAuth: gh<_i59.FirebaseAuth>(),
            googleSignIn: gh<_i116.GoogleSignIn>(),
          ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i99.FirebaseInjectableModule {}
