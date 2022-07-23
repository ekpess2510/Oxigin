import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandedSearchTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function() onTap;
  const ExpandedSearchTile(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(title,
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(18, 18, 18, 1))),
        subtitle: Text(subTitle,
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(18, 18, 18, 0.6))),
        trailing: const SizedBox(),
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Container(
                  height: 40,
                  width: 142,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(18, 18, 18, 1),
                      ),
                      borderRadius: BorderRadius.circular(25)),
                  child: Text('Select Symptoms',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(18, 18, 18, 0.6))),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
