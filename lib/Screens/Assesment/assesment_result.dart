import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myoxigin/Screens/Assesment/widgets/show_answer.dart';

import '../../Constant/selected_list.dart';
import '../../Model/specialist_model.dart';
import '../../Service/api_service.dart';
import '../Home/homescreen.dart';
import 'widgets/ass_result_listtile.dart';
import 'widgets/modal_sheet.dart';

class AssesmentResult extends StatelessWidget {
  final Specialist specialist;
  final List<dynamic> conditions;
  final Map results;

  const AssesmentResult(
      {Key? key, required this.specialist, required this.conditions, required this.results})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Text('Assessment Result',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: HexColor('121212'),
              )),
        ),
        backgroundColor: HexColor('ffffff'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(
              //   'image/container.png',
              //   width: MediaQuery.of(context).size.width,
              //   height: 112,
              // ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 112,
                color: const Color.fromRGBO(18, 18, 18, 1),
                child: Center(
                  child: Image.asset(
                    'image/hosp.png',
                    height: 62,
                    width: 60,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text('Recommendation',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('See a doctor within 24 hours',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(0, 0, 0, 2),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                    'Your symptom may require prompt medical'
                    ' evaluation. If symptoms suddenly get worse, go to the nearest'
                    ' emergency department.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text('Recommended Specialist',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(specialist.recommendedSpecialist!.name,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                color: const Color.fromRGBO(0, 0, 0, 0.7),
                child: TextButton(
                  onPressed: () {},
                  child: Text('Schedule an Appointment',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      )),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text('Result',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                  'Please note this list below may not be complete, and is '
                  'provided solely for informational purpose and is not a '
                  'qualified medical opinion.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                  )),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: conditions.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        getConditions(context, conditions[index]['id'],
                            conditions[index]['probability']);
                      },
                      child: Column(
                        children: [
                          AssesmentListTile(
                            title: conditions[index]['name'],
                            subtitle: conditions[index]['condition_details']
                                ['severity'],
                            trailing: '${conditions[index]['probability']}',
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  })),
              const SizedBox(
                height: 25,
              ),
              Text('Lab Test',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  )),
              const SizedBox(
                height: 15,
              ),
              Text('Preventive ',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                  'This lab test are not related to your symptoms, but are '
                  'recommended due to your risk profile.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                  )),
              const SizedBox(
                height: 25,
              ),
              Text('Morphology and Urinalysis',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                  )),
              const SizedBox(height: 10),
              Text('the package bla bla bla',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                  )),
              const SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color.fromRGBO(18, 18, 18, 1))),
                child: TextButton(
                  onPressed: () {
                    showMaterialModalBottomSheet(
                        expand: true,
                        isDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return ShowAnswer(
                            conditions: conditions,
                          );
                        });
                    //ShowAnswer
                  },
                  child: Text('Show your answers',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(18, 18, 18, 1),
                      )),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return const Homescreen();
                    }), (Route<dynamic> route) => false);
                    items.clear();
                    selectedItems.clear();
                    finalList.clear();
                    results.clear();
                  },
                  child: Text('Back to homepage',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(18, 18, 18, 1),
                      )),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        )),
      ),
    );
  }
}

var service = ApiService();

getConditions(BuildContext context, String id, double probability) {
  service.getCondition('conditions', id).then((value) {
    service.suggestReason('suggest', id, items).then((val) {
      print(val);
      showMaterialModalBottomSheet(
          expand: true,
          isDismissible: true,
          context: context,
          builder: (context) {
            return ModalSheet(
              suggest: val,
              condition: value,
              probability: probability.toString(),
            );
          });
    });
  }).onError((error, stackTrace) {
    print(error);
  });
}
