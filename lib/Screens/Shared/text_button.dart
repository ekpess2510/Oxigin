import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const AppTextButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(18, 18, 18, 1),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(255, 255, 255, 1))),
      ),
    );
  }
}
