import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myoxigin/Screens/Shared/bottom_navigation.dart';

import '../../Constant/selected_list.dart';
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
  final _secureStorage = const FlutterSecureStorage();

  addAssessment(Map results) async {
    var name = await _secureStorage.read(key: 'name');
    CollectionReference reference =
        FirebaseFirestore.instance.collection(name!.replaceAll(' ', ''));
    await reference.add(results).then((value) => print('done'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
              padding: const EdgeInsets.only(top: 25, left: 20, right: 10),
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
                physics: const NeverScrollableScrollPhysics(),
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
                      onPressed(controller.selectedOption, widget.id,
                          widget.question);
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

  onPressed(String option, String id, String questions) async {
    Map<String, dynamic> result = {};
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    if (option == 'No') {
      items.add({'id': id, 'choice_id': 'absent'});
      finalList.add({'question': questions, 'id': id, 'choice': "No"});
      service.postDiagnosis('diagnosis', items).then((value) {
        //items.removeAt(0);
        questions = value.question!.text;
        //finalList.add(value.question!.items[0]);
        if (value.shouldStop == true) {
          service.postSpecialist('recommend_specialist', items).then((val) {
            String encodes = jsonEncode(value.conditions);
            List<dynamic> condition = jsonDecode(encodes);
            result = {
              'date': DateTime.now().toString().substring(0, 16),
              'specialist': val.recommendedSpecialist!.name,
              'condition': condition,
              'response': finalList,
              'items': items
            };
            // result['date'] = DateTime.now().toString().substring(0, 16);
            // result['specialist'] = val.recommendedSpecialist!.name;
            // result['condition'] = condition;
            // result['response'] = finalList;
            // result['items'] = items;
            addAssessment(result);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return NavigationBottomBar(
                  screen: AssesmentResult(
                specialist: val,
                results: result,
                conditions: condition,
              ));
              //   AssesmentResult(
              //   specialist: val,
              //   conditions: condition,
              // );
            })));
          });
        }
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
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
      finalList.add({'question': questions, 'id': id, 'choice': "Yes"});
      service.postDiagnosis('diagnosis', items).then((value) {
        //items.removeAt(0);
        questions = value.question!.text;
        //finalList.add(value.question!.items[0]);
        if (value.shouldStop == true) {
          service.postSpecialist('recommend_specialist', items).then((val) {
            String encodes = jsonEncode(value.conditions);
            List<dynamic> condition = jsonDecode(encodes);
            result = {
              'date': DateTime.now().toString().substring(0, 16),
              'specialist': val.recommendedSpecialist!.name,
              'condition': condition,
              'response': finalList,
              'items': items
            };
            // result['date'] = DateTime.now().toString().substring(0, 16);
            // result['specialist'] = val.recommendedSpecialist!.name;
            // result['condition'] = condition;
            // result['response'] = finalList;
            // result['items'] = items;
            addAssessment(result);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return NavigationBottomBar(
                  screen: AssesmentResult(
                specialist: val,
                results: result,
                conditions: condition,
              ));
            })));
          });
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
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
      finalList.add({'question': questions, 'id': id, 'choice': "Don't know"});
      service.postDiagnosis('diagnosis', items).then((value) {
        //items.removeAt(0);
        questions = value.question!.text;
        //finalList.add(value.question!.items[0]);
        if (value.shouldStop == true) {
          service.postSpecialist('recommend_specialist', items).then((val) {
            String encodes = jsonEncode(value.conditions);
            List<dynamic> condition = jsonDecode(encodes);
            result = {
              'date': DateTime.now().toString().substring(0, 16),
              'specialist': val.recommendedSpecialist!.name,
              'condition': condition,
              'response': finalList,
              'items': items
            };
            // result['date'] = DateTime.now().toString().substring(0, 16);
            // result['specialist'] = val.recommendedSpecialist!.name;
            // result['condition'] = condition;
            // result['response'] = finalList;
            // result['items'] = items;
            addAssessment(result);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return NavigationBottomBar(
                  screen: AssesmentResult(
                specialist: val,
                results: result,
                conditions: condition,
              ));
            })));
          });
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
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
  }
}
