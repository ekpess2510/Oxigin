import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myoxigin/sympage.dart';
import 'Search.dart';
import 'homescreen.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(const MyApp());
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarColor: Colors.red,),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: Scaffold(
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

          body: const Homescreen( )),

      routes: {
        "first":(context)=>Homescreen(),
        "second":(context)=>Sympage(),
        "third":(context)=>Search()
      },
    );
  }
}