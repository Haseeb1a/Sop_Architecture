import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_sop/features/authentication/presentation/provider/auth_provider.dart';
import 'package:task_sop/features/authentication/presentation/view/screens/login_screen.dart';
import 'package:task_sop/features/home/presentation/provider/home_provder.dart';
import 'package:task_sop/features/home/presentation/view/screens/widgets/sort_list.dart';
import 'package:task_sop/features/home/presentation/view/screens/widgets/user_card_item.dart';
import 'package:task_sop/general/utils/appcolors.dart';
import 'package:task_sop/general/utils/text_styles.dart';

import '../../../../../general/widgets/custom_textformfeild.dart';
import '../../../../add_users/presentation/view/screens/add_users_screen.dart';
import '../../../../search/presentation/view/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().init();
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    // final authcontroler = Provider.of<AuthController>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          toolbarHeight: mqSize.height * 0.1,
          leadingWidth: double.infinity,
          backgroundColor: AppColors.dark,
          leading: Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.white,
              ),
              AppStyles.normalText(title: "Nilabur", color: AppColors.white),
            ],
          ),
          actions: [
            Consumer<AuthProvider>(
              builder: (context, authController, child) {
                return IconButton(
                  onPressed: () {
                    authController
                        .signOut()
                        .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            )));
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: AppColors.white,
                  ),
                );
              },
            ),
            const SizedBox(width: 3),
          ],
        ),
        body: Consumer<HomeProvider>(
          builder: (context, homeprovider, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Custom_Textformfeild(
                          ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchUserScreen(),
                              )),
                          readOnlyacitvate: true,
                          iconvisible: true,
                          hinttext: 'Search by name',
                          unvaildText: 'Enter a valid Name',
                        ),
                      ),
                      SizedBox(
                        width: mqSize.width * 0.02,
                      ),
                      IconButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                          backgroundColor: const WidgetStatePropertyAll(
                            AppColors.dark,
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SortList(), // Bottom Sheet
                          );
                        },
                        icon: const Icon(
                          Icons.filter_list_outlined,
                          color: AppColors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: mqSize.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppStyles.normalText(
                        title: 'Users Lists',
                        size: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 7),
                      child: homeprovider.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : homeprovider.usersList.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No users found.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              : ListView.builder(
                                  controller: homeprovider.scrollController,
                                  itemCount: homeprovider.usersList.length,
                                  itemBuilder: (context, index) {
                                    final data = homeprovider.usersList[index];
                                    return Column(
                                      children: [
                                        UserCardItem(
                                          user: data,
                                        ),
                                        if (index ==
                                                homeprovider.usersList.length -
                                                    1 &&
                                            homeprovider.isMoreDataLoading)
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                color: AppColors.dark,
                                              ),
                                            ),
                                          )
                                      ],
                                    );
                                  },
                                ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: SizedBox(
          height: mqSize.height * 0.10,
          width: mqSize.width * 0.15,
          child: FittedBox(
            child: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
              backgroundColor: AppColors.dark,
              shape: const CircleBorder(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddUserDailog(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
