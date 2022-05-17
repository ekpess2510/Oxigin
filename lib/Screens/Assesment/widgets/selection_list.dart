import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectionRadioButton extends StatelessWidget {
  //final int value;
  final void Function(String?)? onChanged;
  final String val;
  final String option;
  const SelectionRadioButton(
      {Key? key, this.onChanged, required this.val, required this.option})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        leading: Radio(
            value: option,
            groupValue: val,
            onChanged: onChanged,
            activeColor: const Color.fromRGBO(18, 18, 18, 1)),
        title: Text(option,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: const Color.fromRGBO(0, 0, 0, 0.7),
            )),
      ),
    );
  }
}
