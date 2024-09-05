import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_sop/features/add_users/presentation/provider/user_add_provider.dart';
import 'package:task_sop/features/add_users/presentation/view/screens/widgets/save_dailog.dart';
import 'package:task_sop/features/home/presentation/provider/home_provder.dart';

import '../../../../../../general/utils/text_styles.dart';
import '../../../../../general/utils/appcolors.dart';
import '../../../../../general/utils/search.dart';
import '../../../../../general/widgets/custom_textformfeild.dart';
import '../../../../../general/widgets/toast_message.dart';
import '../../../../home/data/model/user_model.dart';


class AddUserDailog extends StatelessWidget {
  const AddUserDailog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SingleChildScrollView(
          child: SizedBox(
              height: mqSize.height * .38,
              width: mqSize.width,
              child: Consumer<UserAddProvider>(
                builder: (context, adduserProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppStyles.normalText(
                        title: "Add A New User",
                        size: 15,
                        color: AppColors.dark,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        // child: Stack(
                        //   children: [
                        //     CircleAvatar(
                        //       radius: mqSize.height * 0.08,
                        //       backgroundImage: adduserProvider.imagePath.isEmpty
                        //           ? null
                        //           : FileImage(File(adduserProvider.imagePath)),
                        //     ),
                        //     Positioned(
                        //       left: mqSize.width * 0.01,
                        //       top: mqSize.height * 0.10,
                        //       child: Transform.rotate(
                        //         angle: 3.14 / 1,
                        //         child: ClipRect(
                        //           child: Align(
                        //             alignment: Alignment.topCenter,
                        //             heightFactor: 0.4,
                        //             child: CircleAvatar(
                        //               radius: mqSize.height * 0.075,
                        //               backgroundColor:
                        //                   AppColors.dark.withOpacity(0.1),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Positioned(
                        //       top: mqSize.height * 0.1,
                        //       left: mqSize.width * 0.10,
                        //       child: IconButton(
                        //           onPressed: () {
                        //             showModalBottomSheet(
                        //                 shape: const RoundedRectangleBorder(
                        //                     borderRadius: BorderRadius.only(
                        //                         topLeft: Radius.circular(20),
                        //                         topRight: Radius.circular(20))),
                        //                 context: context,
                        //                 builder: (builder) {
                        //                   return const ImagePickerCard(); //imagepicker card
                        //                 });
                        //           },
                        //           icon: const Icon(
                        //             Icons.camera_alt_outlined,
                        //             size: 25,
                        //             color: AppColors.white,
                        //           )),
                        //     ),
                        //   ],
                        // ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: AppStyles.normalText(
                            title: "Name",
                            fontWeight: FontWeight.w500,
                            size: 14,
                            color: AppColors.grey),
                      ),
                      SizedBox(
                        height: mqSize.height * 0.005,
                      ),
                      Custom_Textformfeild(
                        controller: adduserProvider.nameController,
                        hinttext: "Name",
                        unvaildText: "Please Enter the Name",
                        feildheight: 5,
                      ),
                      SizedBox(
                        height: mqSize.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: AppStyles.normalText(
                            title: "Age",
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                            size: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Custom_Textformfeild(
                        controller: adduserProvider.ageController,
                        hinttext: " Age",
                        unvaildText: "Please Enter the Age",
                        feildheight: 5,
                      ),
                      SizedBox(
                        height: mqSize.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              width: mqSize.width * .28,
                              height: mqSize.height * 0.04,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                            AppColors.offWhiteside)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  adduserProvider.nameController.clear();
                                  adduserProvider.ageController.clear();
                                  adduserProvider.imagePath = '';
                                },
                                child: AppStyles.normalText(
                                    title: 'Cancel',
                                    color: AppColors.grey,
                                    size: 13,
                                    fontWeight: FontWeight.w500),
                              )),
                          SizedBox(
                            width: mqSize.width * 0.03,
                          ),
                          SizedBox(
                              width: mqSize.width * .27,
                              height: mqSize.height * 0.04,
                              child: Consumer<HomeProvider>(
                                  builder: (context, homeProvider, child) {
                                return ElevatedButton(
                                  style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor: WidgetStatePropertyAll(
                                          AppColors.styleBlueshade)),
                                  onPressed: () async {
                                    if (adduserProvider
                                            .nameController.text.isNotEmpty &&
                                        adduserProvider
                                            .ageController.text.isNotEmpty 
                                        ) {
                                      adduserProvider.isLoading = true;

                                      if (adduserProvider.isLoading) {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const SaveDailog());
                                      }
                                      // final image = await AddUserService()
                                      //     .getUserProfilePicture(
                                      //         File(adduserProvider.imagePath));

                                      final user = UserModel(
                                        
                                          name: adduserProvider
                                              .nameController.text,
                                          age: int.parse(adduserProvider
                                              .ageController.text
                                              .trim()),
                                          // image: image,
                                          serach: search(adduserProvider
                                              .nameController.text));
                                      await adduserProvider
                                          .addUser(user)
                                          .then((value) {
                                        homeProvider.addUserLocaly(user);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      });
                                      adduserProvider.isLoading = false;

                                      adduserProvider.clearDatas();
                                    } else {
                                      ToastMessage.showMessage(
                                          'Please add all fields', Colors.red);
                                    }
                                  },
                                  child: AppStyles.normalText(
                                      title: 'Save',
                                      color: AppColors.white,
                                      size: 13,
                                      fontWeight: FontWeight.w500),
                                );
                              })),
                        ],
                      ),
                    ],
                  );
                },
              )
              //   },
              // ),
              )),
    );
  }
}
