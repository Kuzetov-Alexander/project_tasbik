import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class MyStyle {
  const MyStyle._();

  static TextStyle styleTextGreen = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.green,
  );

  static TextStyle styleTextBlue = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: const Color(0xff4664FF),
  );

  static TextStyle styleTextWhite = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle styleTextValidator =
      GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w400);

  static TextStyle styleTextW7 =
      GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w700);

  static TextStyle styleText =
      GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle styleTextSmall =
      GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600);
}
