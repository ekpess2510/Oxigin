import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SymContainer extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  const SymContainer({Key? key, required this.name, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: const Color.fromRGBO(18, 18, 18, 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text(name,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(18, 18, 18, 1),
                  )),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                  onTap: onPressed,
                  child: const Icon(
                    Icons.cancel,
                    size: 16,
                  )),
              //IconButton(onPressed: onPressed, icon: const Icon(Icons.cancel))
            ],
          ),
        ),
      ),
    );
  }
}
