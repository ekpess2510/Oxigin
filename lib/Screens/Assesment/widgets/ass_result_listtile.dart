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
      contentPadding: const EdgeInsets.all(5),
      title: Text(title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(0, 0, 0, 0.7),
          )),
      subtitle: Text(
          subtitle == 'mild'
              ? 'Mild Evidence'
              : subtitle == 'moderate'
                  ? 'Moderate Evidence'
                  : 'Severe Evidence',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(0, 0, 0, 0.7),
          )),
      trailing: Text(trailing,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: subtitle == 'severe'
                ? const Color.fromARGB(255, 136, 18, 18)
                : subtitle == 'mild'
                    ? Colors.black
                    : Colors.green,
          )),
    );
  }
}
