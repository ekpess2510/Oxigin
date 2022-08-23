import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constant/selected_list.dart';

class ShowAnswer extends StatelessWidget {
  final List<dynamic> conditions;
  const ShowAnswer({Key? key, required this.conditions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                alignment: Alignment.bottomLeft,
                color: const Color.fromRGBO(18, 18, 18, 0.06),
                child: ListTile(
                  title: Text('Your Answer',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      )),
                ),
              ),
              const SizedBox(height: 20),
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
                child: Text('Summary of response provided by you',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Symptoms',
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
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: conditions.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return Text('◉ ${conditions[index]['name']}');
                    })),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Responses',
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
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: finalList.length,
                    padding: const EdgeInsets.only(bottom: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "◉ ${finalList[index]['question']}",
                            style: GoogleFonts.inter(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            finalList[index]['choice'],
                            style: GoogleFonts.inter(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    })),
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
