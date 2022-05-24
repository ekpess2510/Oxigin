import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Home/homescreen.dart';
import 'Screens/SplashScreen/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loggedIn = prefs.getBool('loggedIn');
  runApp(ProviderScope(
      child: MyApp(
    isLoggedIn: loggedIn,
  )));
}

class MyApp extends StatelessWidget {
  var isLoggedIn;
  MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oxigin',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: isLoggedIn == true ? const Homescreen() : const SplashScreen(),
      // routes: {
      //   "first": (context) => Homescreen(),
      //   "second": (context) => Sympage(),
      //   "third": (context) => Search()
      // },
    );
  }
}
