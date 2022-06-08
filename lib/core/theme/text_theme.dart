import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/core/theme/color_theme.dart';

class ThemeText {
  static TextStyle baseStyle = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
  );

  static TextStyle alternativeStyle = GoogleFonts.vollkorn(
    color: ThemeColor.typography,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleStyle = baseStyle.copyWith(fontSize: 24);
  static TextStyle bodyStyle = baseStyle.copyWith(fontSize: 16);
  static TextStyle captionStyle = baseStyle.copyWith(fontSize: 12);
  static TextStyle heroStyle = titleStyle.copyWith(
    fontWeight: FontWeight.w600,
  );
}
