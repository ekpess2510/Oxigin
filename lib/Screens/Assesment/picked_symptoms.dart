import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Constant/selected_list.dart';
import '../../Constant/symp_list.dart';
import '../../Service/api_service.dart';
import '../SearchScreen/Search.dart';
import 'assesment_result.dart';
import 'symptoms_options.dart';
import 'widgets/symptoms_container.dart';

class PickedSystoms extends ConsumerStatefulWidget {
  const PickedSystoms({Key? key}) : super(key: key);

  @override
  _PickedSystomsState createState() => _PickedSystomsState();
}

class _PickedSystomsState extends ConsumerState<PickedSystoms> with AutomaticKeepAliveClientMixin<PickedSystoms>{
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    //final data = ref.read(diagnosisProvider);
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
            child: Row(
              children: [
                Text('Your Assessment',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: HexColor('121212'),
                    )),
                const Spacer(),
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(119,184,251, 1),
                        width: 2
                    ),
                    shape: BoxShape.circle,
                    // image: const DecorationImage(image: AssetImage('image/avatar.png'),
                    // fit: BoxFit.cover
                    // ),
                  ),
                  child: Center(
                    child: Image.asset('image/avatar.png'),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: HexColor('ffffff'),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const Spacer(),
                      const SizedBox(
                        height: 78,
                        width: 52,
                        child: Image(
                          image: AssetImage('image/log.png'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Here’s your symptoms',
                            style: TextStyle(
                              fontFamily: 'Recoleta',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('Please add more than one symptom',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: const Color.fromRGBO(0, 0, 0, 0.7),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 30,
                        child: ListView.builder(
                            itemCount: selectedItems.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return SymContainer(
                                name: selectedItems[index],
                                onPressed: () {
                                  setState(() {
                                    items.removeAt(index);
                                    selectedItems.removeAt(index);
                                  });
                                },
                              );
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: SizedBox(
                            height: 52,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'E.g headache',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16))),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return const Search();
                                })));
                              },
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 42),
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
                            //print(items);
                            onPressed();
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
                    ))
              ],
            ),
          ),
        ));
  }

  var service = ApiService();

  onPressed() async {
    Map result = {};
    service.postDiagnosis('diagnosis', items).then((value) {
      questions = value.question!.text;
      if (value.shouldStop == true) {
        service
            .postSpecialist('recommend_specialist', items)
            .then((val) {
          String encodes = jsonEncode(value.conditions);
          //print(encodes);
          List<dynamic> condition = jsonDecode(encodes);
          result['specialist'] = val.recommendedSpecialist!.name;
          result['condition'] = condition;
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return AssesmentResult(
              specialist: val,
              results: result,
              conditions: condition,
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
}
