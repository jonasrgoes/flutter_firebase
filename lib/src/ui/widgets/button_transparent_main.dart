import 'package:flutter/material.dart';

class ButtonTransparentMain extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final double marginLeft;
  final double marginRight;
  final double height;
  final double width;
  final double fontSize;
  final Color borderColor;
  final Color textColor;

  const ButtonTransparentMain({
    Key? key,
    required this.callback,
    required this.text,
    required this.marginLeft,
    required this.marginRight,
    required this.height,
    this.width = 0,
    required this.fontSize,
    required this.borderColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: EdgeInsets.only(left: marginLeft, right: marginRight),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: 1, color: borderColor)),
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: fontSize),
        ),
      ),
    );
  }
}
