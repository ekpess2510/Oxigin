import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/homescreen.dart';
import '../Login/login_screen.dart';
import '../Shared/text_button.dart';
import '../Shared/text_fields.dart';
import 'insert_signup_password.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  List<String> gender = ['Male', 'Female'];
  String? selectedGender;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: HexColor('ffffff'),
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          toolbarHeight: 10,
          // leading: Padding(
          //   padding: const EdgeInsets.only(top: 15),
          //   child: Image.asset('image/log.png', height: 52, width: 35),
          // ),
          backgroundColor: HexColor('ffffff'),
          elevation: 0,
          leadingWidth: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Image.asset('image/log.png', height: 52, width: 35),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Create An Account',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromRGBO(18, 18, 18, 1))),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Please create an account to get more of Oxigin',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(18, 18, 18, 0.8))),
                      const SizedBox(
                        height: 30,
                      ),
                      Text('FULL NAME',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(18, 18, 18, 1))),
                      const SizedBox(
                        height: 5,
                      ),
                      AppTextField(
                        hintText: 'Type your full name',
                        controller: _fullNameController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Field must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('EMAIL',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(18, 18, 18, 0.45))),
                      const SizedBox(
                        height: 5,
                      ),
                      AppTextField(
                        hintText: 'Type your email',
                        controller: _emailController,
                        validator: (text) {
                          RegExp emailValid = RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                          if (text!.isEmpty) {
                            return 'Field must not be empty';
                          }
                          if (!emailValid.hasMatch(text)) {
                            return 'Email not correct';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('AGE',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(18, 18, 18, 0.45))),
                      const SizedBox(
                        height: 5,
                      ),
                      AppTextField(
                        hintText: 'Enter your age',
                        controller: _ageController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Field must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('GENDER',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(18, 18, 18, 0.45))),
                      const SizedBox(
                        height: 5,
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedGender,
                        decoration: const InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(16.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(18, 18, 18, 0.45), width: 1),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(18, 18, 18, 1), width: 1),
                          ),
                          errorBorder:  OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(18, 18, 18, 0.45), width: 1),
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromRGBO(18, 18, 18, 1), width: 1),
                          ),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Field can't be empty";
                          } else {
                            return null;
                          }
                        },
                        items: gender.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      // AppTextField(
                      //   hintText: '',
                      //   controller: _genderController,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextButton(
                        text: 'Proceed',
                        onPressed: () {
                          //saveDetails();
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return SignUpPasswordScreen(
                              email: _emailController.text,
                              userName: _fullNameController.text,
                              age: _ageController.text,
                              gender: selectedGender!,
                            );
                          })));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          'Oxigin will send you members-only deals, and push notifications. You can opt out of '
                          'receiving these at any time in your account settings or directly from the '
                          'marketing notification.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(18, 18, 18, 0.56))),
                    ]),
                const SizedBox(height: 40),
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Already have an account? ',
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(18, 18, 18, 0.56))),
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(18, 18, 18, 1),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const LoginScreen()));
                            },
                        ),
                      ])),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _emailController.text);
    prefs.setString('age', _ageController.text);
    prefs.setString('gender', selectedGender!);
    prefs.setString('name', _fullNameController.text);
    prefs.setBool('loggedIn', true);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Homescreen(
        name: _fullNameController.text,
      );
    }));
  }
}
