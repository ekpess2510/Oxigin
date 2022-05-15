import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('ffffff'),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),

        title: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Text('', style: GoogleFonts.inter(
            fontSize: 20, fontWeight: FontWeight.bold, color: HexColor('121212'),
          )),
        ),
        backgroundColor: HexColor('ffffff'),
        elevation: 0,
      ),
      body: Padding(
        padding:  const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child:SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [



              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Search for a symptom.', style: TextStyle(fontFamily: 'Recoleta', fontSize: 22, fontWeight: FontWeight.w500, )),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: SizedBox(
                        height: 52,

                        child:TextFormField(
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            label: Text('E.g headache'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),

                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)
                              )
                          ),
                          onTap: (){

                          },
                        )
                    ),
                  )
                ],
              ),

            ],
          ),
        ),

      ),
    );
  }
}
