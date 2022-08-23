import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'ViewAssessment/view_assessment.dart';

class Assessments extends StatelessWidget {
  final String doc;

  const Assessments({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(doc);
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
          child: Text('My Assessment',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor('121212'),
              )),
        ),
        backgroundColor: HexColor('ffffff'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(doc)
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(51, 51, 51, 1),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {

                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      QueryDocumentSnapshot<Object?> page = snapshot.data!.docs[index];
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, (MaterialPageRoute(builder: (context){
                            return ViewAssessment(assessment: page);
                          })));
                        },
                        child: AssessmentTile(
                            date: snapshot.data!.docs[index]['date'],
                            name: snapshot.data!.docs[index]['condition'][0]
                                ['common_name'],
                            symptoms: snapshot.data!.docs[index]['condition']),
                      );
                    }));
              }
              return const Center(child: Text('No previous assessment'));
            }
            return const Text('Something went wrong, retry later');
          }),
    );
  }
}

class AssessmentTile extends StatelessWidget {
  final String date, name;
  final List symptoms;

  const AssessmentTile(
      {Key? key,
      required this.date,
      required this.name,
      required this.symptoms})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 106,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                name,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: symptoms.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text("${symptoms[index]['common_name']},"),
                  );
                })),
          ),
          const SizedBox(height: 5),
          const Divider()
        ],
      ),
    );
  }
}
