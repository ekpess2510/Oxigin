import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Sympage extends StatefulWidget {
  const Sympage({Key? key}) : super(key: key);

  @override
  State<Sympage> createState() => _SympageState();
}

class _SympageState extends State<Sympage> {
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
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Text('Welcome', style: GoogleFonts.inter(
            fontSize: 20, fontWeight: FontWeight.bold, color: HexColor('121212'),
          )),
        ),
        backgroundColor: HexColor('ffffff'),
        elevation: 0,
      ),
      body: Padding(
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
                    child: Text('Let’s start with the symptom \n'
                        'that is troubling you the most.', style: TextStyle(fontFamily: 'Recoleta', fontSize: 22, fontWeight: FontWeight.w500, )),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: SizedBox(
                      height: 52,

                      child:TextFormField(
                        decoration: InputDecoration(
                            labelText: 'E.g headache',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)
                            )
                        ),
                        onTap: (){
                          Navigator.pushReplacementNamed(context, "third");
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







// ElevatedButton(
//
// style: ButtonStyle(
// shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),),
// backgroundColor: MaterialStateProperty.all(HexColor('121212'))),
// onPressed:(){
// Navigator.push(context, MaterialPageRoute(builder: (context) => Sympage()));
// }
// , child: Text('Start Symptom Assessment', style:  GoogleFonts.inter(
// fontSize: 14, fontWeight: FontWeight.w400, color: HexColor('ffffff'),
// ) ,)),