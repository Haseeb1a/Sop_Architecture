import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_sop/features/home/data/i_home_facade.dart';
import 'package:task_sop/features/home/presentation/provider/home_provder.dart';
import 'package:task_sop/features/search/presentation/provider/search_provider.dart';
import 'package:task_sop/general/core/di/injection.dart';

import 'features/add_users/data/I_add_user_facade.dart';
import 'features/add_users/presentation/provider/user_add_provider.dart';
import 'features/authentication/data/i_auth_facade.dart';
import 'features/authentication/presentation/provider/auth_provider.dart';
import 'features/authentication/presentation/view/screens/login_screen.dart';
import 'features/search/data/I_search_facade.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependency();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authticationFacde: sl<AuthticationFacde>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(
            homeFacade: sl<IHomeFacade>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => UserAddProvider(
            addUserFacade: sl<IAddUserFacade>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(
            ISearchFacade: sl<ISearchFacade>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
