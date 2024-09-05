import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_sop/general/utils/appcolors.dart';

class Custom_Textformfeild extends StatelessWidget {
 final String unvaildText;
  final String hinttext;
  final Color hintcolor;
  final int maxline;
  final Color iconColor;
  final TextEditingController? controller;
  final TextInputType keybordtype;
  final bool obscureText;
  final bool iconvisible;
  final double feildheight;
  final Function(String)? onButtonPressed;
  final bool readOnlyacitvate;
  final VoidCallback? ontap;
  Custom_Textformfeild(
      {super.key,
      this.keybordtype = TextInputType.name,
      this.readOnlyacitvate=false,
      this.onButtonPressed,
      this.obscureText = false,
      this.ontap,
      required this.hinttext,
      this.controller,
      this.hintcolor = AppColors.dark,
      this.maxline = 1,
      this.iconColor = AppColors.dark,
      required this.unvaildText,
      this.iconvisible = false,
      this.feildheight = 15.0});

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    return TextFormField(
      onTap: ontap,
      readOnly: readOnlyacitvate,
        onChanged:onButtonPressed,
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppColors.styleBlue,
        maxLines: maxline,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a $unvaildText';
          } else {
            return null;
          }
        },
        keyboardType: keybordtype,
        decoration: iconvisible
            ? InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: mqSize.width * 0.03),
                  child: const Icon(
                    Icons.search_rounded,
                    size: 30,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                hintText: '  search by name',
                hintStyle: GoogleFonts.montserrat(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 1,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    )),
              )
            : InputDecoration(
                hintText: hinttext,
                contentPadding:
                    EdgeInsets.symmetric(vertical: feildheight, horizontal: 16),
                hintStyle: GoogleFonts.montserrat(
                    color: AppColors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                labelText: hinttext,
                labelStyle: TextStyle(color: hintcolor),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.grey,
                      width: 1,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.dark,
                      width: 2,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.error,
                      width: 2,
                    )),
              ));
  }
}
