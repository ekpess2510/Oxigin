import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Provider/auth_provider.dart';
import '../Shared/text_button.dart';
import '../Shared/text_fields.dart';

class ForgetPassword extends ConsumerWidget {
  ForgetPassword({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(authRepositoryProvider);

    resetPassword() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      await model.sendPasswordInfo(
          context: context, email: _emailController.text);
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('image/log.png', height: 52, width: 35),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Forgot Password???',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(18, 18, 18, 1))),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Enter the email you use to register with us and we will send you a reset link',
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
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Enter Field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextButton(
                      text: 'Login',
                      onPressed: () {
                        resetPassword();
                        /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const Homescreen(
                          name: '',
                        );
                      }));*/
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
