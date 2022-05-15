import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myoxigin/sympage.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child:SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [



Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const SizedBox(
      height: 78,
      width: 52,
      child: Image(image:AssetImage('image/log.png') ,),
    ),

    Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text('Hello Emmanuel, sorry about '
        'how you feel, lets start a symptom assesment to know whats wrong.', style: TextStyle(fontFamily: 'Recoleta', fontSize: 22, fontWeight: FontWeight.w500, )),
    ),

    Padding(
      padding: const EdgeInsets.only(top: 32),
      child: SizedBox(
      height: 52,

      child: ElevatedButton(

          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),),
              backgroundColor: MaterialStateProperty.all(HexColor('121212'))),
          onPressed:(){
            Navigator.pushReplacementNamed(context, "second");
          }
          , child: Text('Start Symptom Assessment', style:  GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: HexColor('ffffff'),
      ) ,)),
      ),
    )
  ],
),

            ],
          ),
        ),

    );
  }
}
