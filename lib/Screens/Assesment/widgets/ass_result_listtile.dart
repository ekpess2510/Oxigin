import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssesmentListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailing;
  const AssesmentListTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(0, 0, 0, 0.7),
          )),
      subtitle: Text(subtitle,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(0, 0, 0, 0.7),
          )),
      trailing: Text(trailing,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(1, 165, 96, 1),
          )),
    );
  }
}
