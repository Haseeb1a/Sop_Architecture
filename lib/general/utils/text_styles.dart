import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  // normal text with atributes--------------------
  static normalText({
    required String title,
    Color color = Colors.black,
    double? size,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
