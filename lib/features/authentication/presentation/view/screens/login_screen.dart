import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_sop/features/home/presentation/view/screens/home_page.dart';

import '../../../../../general/utils/appcolors.dart';
import '../../../../../general/utils/text_styles.dart';
import '../../../../../general/widgets/toast_message.dart';
import '../../provider/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqsize = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(builder: (context, state, _) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/login_image.png',
                  height: mqsize.height * 0.2,
                  width: mqsize.width * 0.4,
                  fit: BoxFit.contain,
                )),
                SizedBox(
                  height: mqsize.height * 0.06,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(
                            color: AppColors.dark,
                            width: 2.0,
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        state.loginWithGoogleSingUP(successgoogleAuth: () {

                         Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>const HomeScreen(),
                              ));
                        }, authfailure: (error) {
                          
                          ToastMessage.showMessage(
                              error.toString(), AppColors.styleBlueshade);
                         
                        }
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXdZstnFOO87-aJ43mJ_-R2gGYO8SV9A_GAw&s',
                            ),
                          ),
                          Text(
                            'Sign With Google',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                ),
                // SizedBox(
                //   height: mqsize.height * 0.1,
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 6),
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: AppStyles.normalText(
                //         title: "Enter Phone Number", size: 18),
                //   ),
                // ),
                // SizedBox(
                //   height: mqsize.height * 0.02,
                // ),
                //   ),
                // Consumer<AuthProvider>(
                //   builder: (context, authProvider, child) {
                //     return Custom_Textformfeild(
                //       controller: authProvider.numberController,
                //       hinttext: 'Enter Mobile Number',
                //       unvaildText: "Enter Valid Number",
                //       keybordtype: TextInputType.number,
                //     );
                //   },
                // ),
                SizedBox(
                  height: mqsize.height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.montserrat(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    children: [
                      const TextSpan(
                          text: 'By Continuing, I agree to TotalXs '),
                      TextSpan(
                        text: 'Terms and condition',
                        style: TextStyle(color: AppColors.styleBlue),
                      ),
                      const TextSpan(text: ' & '),
                      TextSpan(
                        text: 'privacy Policy',
                        style: TextStyle(color: AppColors.styleBlue),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mqsize.height * 0.04,
                ),
                // SizedBox(
                //     height: mqsize.height * 0.06,
                //     width: double.infinity,
                //     child: Consumer<AuthProvider>(
                //       builder: (context, authProvider, child) {
                //         return ElevatedButton(
                //           style: const ButtonStyle(
                //             backgroundColor: WidgetStatePropertyAll(Colors.black),
                //           ),
                //           onPressed: () {
                //             if (authProvider.numberController.text.length == 10) {
                //               authProvider.signWithPhone(context);
                //             } else if (authProvider
                //                 .numberController.text.isEmpty) {
                //               ToastMessage.showMessage(
                //                   'Please enter the phone number',
                //                   AppColors.error);
                //             } else if (authProvider.numberController.text.length <
                //                     10 ||
                //                 authProvider.numberController.text.length > 10) {
                //               ToastMessage.showMessage(
                //                   'Please enter a 10 digit number',
                //                   AppColors.error);
                //             }
                //           },
                //           child: AppStyles.normalText(
                //               title: 'Get OTP', color: AppColors.white, size: 15),
                //         );
                //       },
                //     ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
