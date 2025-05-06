import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static poppins_16_400(String text, {Color color = Colors.black}) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }

  static poppins_15_300(String text, {Color color = Colors.black}) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: color,
      ),
    );
  }

  static actor_14_400(String text, {Color color = Colors.black}) {
    return Text(
      text,
      style: GoogleFonts.actor(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }

  static acme_20_400(String text, {Color color = Colors.black}) {
    return Text(
      text,
      style: GoogleFonts.acme(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }
}
