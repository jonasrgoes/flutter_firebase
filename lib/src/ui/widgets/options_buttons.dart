import 'package:flutter/material.dart';

class OptionsButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const OptionsButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white70,
          size: 32.0,
        ),
        const SizedBox(
          width: 12.0,
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w400,
              fontSize: 23.0),
        ),
        const Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
