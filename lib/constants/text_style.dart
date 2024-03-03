import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_ieee/constants/colors.dart';
class TextAppStyle{
  static TextStyle btnStyle (){
    return GoogleFonts.poppins(fontSize: 20,color: MyColor.DarkGrey,fontWeight: FontWeight.w500);
  }
  static TextStyle scanerbar (){
    return GoogleFonts.roboto(fontSize: 20,color: MyColor.White,fontWeight: FontWeight.w800);
  }
  static TextStyle scanerText (){
    return GoogleFonts.lato(fontSize: 20,color: MyColor.DarkGrey,fontWeight: FontWeight.w600);
  }
}