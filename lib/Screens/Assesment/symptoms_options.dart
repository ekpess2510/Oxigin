import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Constant/selected_list.dart';
import '../../Constant/symp_list.dart';
import '../../Model/diagnosis_model.dart';
import '../../Service/api_service.dart';
import 'Controller/symptoms_options_controller.dart';
import 'assesment_result.dart';
import 'widgets/selection_list.dart';

class SymptomsOptions extends ConsumerStatefulWidget {
  final String question, id;
  final List<Choice> option;
  final int size;

  const SymptomsOptions(
      {Key? key,
      required this.question,
      required this.option,
      required this.size,
      required this.id})
      : super(key: key);

  @override
  SymptomsOptionsState createState() => SymptomsOptionsState();
}

class SymptomsOptionsState extends ConsumerState<SymptomsOptions> {
  String result = '';

  @override
  Widget build(BuildContext context) {
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
              child: Text(widget.question,
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
                itemCount: widget.size,
                itemBuilder: ((context, index) {
                  return SelectionRadioButton(
                    val: controller.selectedOption,
                    option: widget.option[index].label,
                    onChanged: (String? value) {
                      setState(() {
                        controller.onSelection(value, result);
                      });
                    },
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
                      onPressed(controller.selectedOption, widget.id);
                      controller.selectedOption = '';
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: ((context) {
                      //   return const AssesmentResult();
                      // })));
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

  var service = ApiService();

  onPressed(String option, String id) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    if (option == 'No') {
      items.add({'id': id, 'choice_id': 'absent'});
      service.postDiagnosis('diagnosis', 'male', 20, items).then((value) {
        //items.removeAt(0);
        print(items);
        questions = value.question!.text;
        if (value.shouldStop == true) {
          service
              .postSpecialist('recommend_specialist', 'male', 20, items)
              .then((val) {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return AssesmentResult(
                specialist: val,
                conditions: value.conditions,
              );
            })));
          });
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SymptomsOptions(
            size: value.question!.items[0].choices!.length,
            option: value.question!.items[0].choices!,
            question: questions,
            id: value.question!.items[0].id,
          );
        }));
      });
    } else if (option == 'Yes') {
      items.add({'id': id, 'choice_id': 'present'});
      service.postDiagnosis('diagnosis', 'male', 20, items).then((value) {
        //items.removeAt(0);
        print(items);
        questions = value.question!.text;
        if (value.shouldStop == true) {
          service
              .postSpecialist('recommend_specialist', 'male', 20, items)
              .then((val) {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return AssesmentResult(
                specialist: val,
                conditions: value.conditions,
              );
            })));
          });
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SymptomsOptions(
              size: value.question!.items[0].choices!.length,
              option: value.question!.items[0].choices!,
              question: questions,
              id: value.question!.items[0].id,
            );
          }));
        }
      });
    } else if (option == "Don't know") {
      items.add({'id': id, 'choice_id': 'unknown'});
      service.postDiagnosis('diagnosis', 'male', 20, items).then((value) {
        //items.removeAt(0);
        print(items);
        questions = value.question!.text;
        if (value.shouldStop == true) {
          service
              .postSpecialist('recommend_specialist', 'male', 20, items)
              .then((val) {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return AssesmentResult(
                specialist: val,
                conditions: value.conditions,
              );
            })));
          });
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SymptomsOptions(
              size: value.question!.items[0].choices!.length,
              option: value.question!.items[0].choices!,
              question: questions,
              id: value.question!.items[0].id,
            );
          }));
        }
      });
    }
    // service.postDiagnosis('diagnosis', 'male', 20, items).then((value) {
    //   if (value.question != null) {
    //     tempList.clear();
    //     diagnoList.clear();
    //     if (result == 'No') {
    //       Map<String, String> rand = {
    //         'id': value.question.items[0].id,
    //         "choice_id": 'absent'
    //       };
    //       items.add(rand);
    //     } else {
    //       Map<String, String> rand = {
    //         'id': value.question.items[0].id,
    //         "choice_id": 'present'
    //       };
    //       items.add(rand);
    //     }
    //     for (var i = 0; i < value.question.items.length; i++) {
    //       if (value.question.type == 'single') {
    //         for (int j = 0; j < value.question.items[0].choices!.length; j++) {
    //           // tempList.add(value.question.items[0].choices[j].label);
    //         }
    //       } else {
    //         //tempList.add(value.question.items[i].name);
    //       }
    //     }
    //     print(value.conditions.length);
    //     diagnoList.add(value.conditions[0]);
    //     for (var i = 0; i < value.conditions.length; i++) {
    //       diagnoList.add(value.conditions[i]);
    //     }
    //     print(value.conditions[0].probability);
    //     questionAsk++;
    //     if (questionAsk < 4) {
    //       // Navigator.pushReplacement(context,
    //       //     MaterialPageRoute(builder: (context) {
    //       //   return SymptomsOptions(
    //       //     question: value.question.text,
    //       //   );
    //       // }));
    //     } else {
    //       Navigator.push(context, MaterialPageRoute(builder: ((context) {
    //         return const AssesmentResult();
    //       })));
    //     }
    //   } else {
    //     Navigator.push(context, MaterialPageRoute(builder: ((context) {
    //       return const AssesmentResult();
    //     })));
    //   }
    // });
  }

  List<Widget> _pageList = [];
}
