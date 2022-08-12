import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Provider/auth_provider.dart';
import '../Shared/text_button.dart';
import '../Shared/text_fields.dart';
import '../Signup/signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(authRepositoryProvider);

    login() async{
      if (!_formKey.currentState!.validate()) {
        return;
      }
      await model.signInWithEmailAndPassword(_emailController.text,
          _passwordController.text, context);
    }

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
          toolbarHeight: 100,
          // leading: Padding(
          //   padding: const EdgeInsets.only(top: 15),
          //   child: Image.asset('image/log.png', height: 52, width: 35),
          // ),
          backgroundColor: HexColor('ffffff'),
          elevation: 0,
          leadingWidth: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.asset('image/log.png', height: 52, width: 35),
                const SizedBox(
                  height: 20,
                ),
                Text('Welcome!!!',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(18, 18, 18, 1))),
                const SizedBox(
                  height: 10,
                ),
                Text('Sign into your oxigin account',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(18, 18, 18, 0.8))),
                const SizedBox(
                  height: 30,
                ),
                Text('Email',
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(18, 18, 18, 1))),
                const SizedBox(
                  height: 5,
                ),
                AppTextField(
                  hintText: 'Type your email',
                  controller: _emailController,
                  validator: (text){
                    if(text!.isEmpty){
                      return 'Enter Field';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Text('Password',
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(18, 18, 18, 0.45))),
                const SizedBox(
                  height: 5,
                ),
                AppTextField(
                  hintText: 'Type your password',
                  controller: _passwordController,
                  obscure: true,
                  validator: (text){
                    if(text!.isEmpty){
                      return 'Enter Field';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text('Forgot password?',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(18, 18, 18, 1))),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextButton(
                  text: 'Login',
                  onPressed: () {
                    login();
                    /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const Homescreen(
                        name: '',
                      );
                    }));*/
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
                const Spacer(),
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Don't have an account? ",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(18, 18, 18, 0.56))),
                    TextSpan(
                      text: 'Create An Account',
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
                                  builder: (context) => const SignupScreen()));
                        },
                    ),
                  ])),
                ),
                const SizedBox(
                  height: 40,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
