import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Constant/symp_list.dart';
import 'Controller/symptoms_options_controller.dart';
import 'assesment_result.dart';
import 'widgets/selection_list.dart';

class SymptomsOptions extends ConsumerWidget {
  final String question;
  const SymptomsOptions({Key? key, required this.question}) : super(key: key);

  // @override
  // void dispose() {
  //   tempList.clear();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(symNotifier);
    return Scaffold(
      backgroundColor: HexColor('ffffff'),
      appBar: AppBar(
        leadingWidth: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Text('Your Assessment',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: HexColor('121212'),
              )),
        ),
        backgroundColor: HexColor('ffffff'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 2,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 20),
              child: Text(question,
                  style: const TextStyle(
                    fontFamily: 'Recoleta',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Please select one answer.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                  )),
            ),
            const SizedBox(
              height: 25,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: tempList.length,
                itemBuilder: ((context, index) {
                  return SelectionRadioButton(
                    val: controller.selectedOption,
                    option: tempList[index],
                    onChanged: controller.onSelection,
                  );
                })),
            Padding(
              padding: const EdgeInsets.only(top: 52, left: 20, right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(0, 0, 0, 0.7),
                        )),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return const AssesmentResult();
                      })));
                    },
                    child: Container(
                      height: 48,
                      width: 97,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(18, 18, 18, 1),
                          borderRadius: BorderRadius.circular(25)),
                      child: Text('Next',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
