import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? obscure;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  const AppTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscure = false,
      this.validator, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscure!,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          hintStyle: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(204, 204, 204, 1)),
          contentPadding: const EdgeInsets.all(18.0),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(18, 18, 18, 0.45), width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(18, 18, 18, 1), width: 1),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(18, 18, 18, 0.45), width: 1),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(18, 18, 18, 1), width: 1),
          ),
        ));
  }
}
