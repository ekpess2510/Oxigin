import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../Model/condition_model.dart';

class ModalSheet extends StatelessWidget {
  // final String title;
  // final String percentage;
  // final String reason;
  final Condition condition;
  const ModalSheet(
      {Key? key,
      required this.condition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                alignment: Alignment.bottomLeft,
                color: const Color.fromRGBO(18, 18, 18, 0.06),
                child: ListTile(
                  title: Text(condition.name,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      )),
                  subtitle: Text('${condition.prevalence} evidence',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(18, 18, 18, 1),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Hint:',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(condition.extras!.hint,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Reasons For',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(condition.acuteness,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Prevalence',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(condition.prevalence,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(18, 18, 18, 0.06),
                  shape: BoxShape.circle),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  size: 35,
                  color: Color.fromRGBO(18, 18, 18, 0.4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
