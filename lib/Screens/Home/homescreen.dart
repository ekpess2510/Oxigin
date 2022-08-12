import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myoxigin/Screens/Home/sympage.dart';

import '../../Provider/auth_provider.dart';

class Homescreen extends ConsumerStatefulWidget {
  final String? name;

  const Homescreen({Key? key, this.name}) : super(key: key);

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  String? age;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(fireBaseAuthProvider);

    Future<DocumentSnapshot> getInfo() async {
      var fireStore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await fireStore.collection('users').doc(data.currentUser!.uid).get();
      return snapshot;
    }

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
            child: Text('Welcome',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: HexColor('121212'),
                )),
          ),
          backgroundColor: HexColor('ffffff'),
          elevation: 0,
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: getInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 78,
                                width: 52,
                                child: Image(
                                  image: AssetImage('image/log.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                    'Hello ${snapshot.data!['full_name']}, sorry about '
                                    'how you feel, lets start a symptom assesment to know whats wrong.',
                                    style: const TextStyle(
                                      fontFamily: 'Recoleta',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 32),
                                child: SizedBox(
                                  height: 52,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  HexColor('121212'))),
                                      onPressed: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: ((context) {
                                          return const Sympage();
                                        })));
                                      },
                                      child: Text(
                                        'Start Symptom Assessment',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor('ffffff'),
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
            }));
  }
}
