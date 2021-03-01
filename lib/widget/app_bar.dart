import 'package:bible_app/constant/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


AppBar appBar({
  @required String title,
  Color textColor = Colors.black,
  Color borderColor = CustomColors.orange3,
  double borderWidth = 2,
  PreferredSize bottom,
}){
  return AppBar(
    backgroundColor: const Color(0xFFFFF5E8),
    title:  Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: 20,
      ),
    ),
    elevation: 0,
    shape:Border(
      bottom: BorderSide(
        width: borderWidth,
        color: borderColor,
      ),
    ),
    bottom: bottom,
    centerTitle: true,
  );
}
