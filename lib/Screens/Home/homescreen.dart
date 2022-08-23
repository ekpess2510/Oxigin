import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myoxigin/Screens/Home/sympage.dart';
import 'package:myoxigin/Screens/Shared/bottom_navigation.dart';

import '../../Provider/auth_provider.dart';
import '../Profile/profile.dart';

class Homescreen extends ConsumerStatefulWidget {
  final String? name;

  const Homescreen({Key? key, this.name}) : super(key: key);

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen>
    with AutomaticKeepAliveClientMixin<Homescreen> {
  String? age;

  PageController? _myPage;
  int? selectedPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myPage = PageController(initialPage: 0);
    selectedPage = 0;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final data = ref.watch(fireBaseAuthProvider);

    Future<DocumentSnapshot> getInfo() async {
      var fireStore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await fireStore.collection('users').doc(data.currentUser!.uid).get();
      return snapshot;
    }

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _myPage,
        children: [
          Scaffold(
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
                child: Row(
                  children: [
                    Text('Welcome',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: HexColor('121212'),
                        )),
                    const Spacer(),
                    const CircleAvatar(
                      backgroundImage: AssetImage('image/avatar.png'),
                      //backgroundColor: Colors.grey,
                      radius: 32,
                    )
                  ],
                ),
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
                                                        BorderRadius.circular(
                                                            16)),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      HexColor('121212'))),
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: ((context) {
                                              return const NavigationBottomBar(
                                                screen: Sympage(),
                                              );
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
                }),
          ),
          const ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        //elevation: 0,
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          height: 80,
          color: const Color.fromRGBO(238, 238, 238, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  _myPage!.jumpToPage(0);
                  setState(() {
                    selectedPage = 0;
                  });
                },
                child: Column(
                  children: [
                    selectedPage == 0
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.modulate),
                            child: Image.asset('image/home.png'))
                        : ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.7),
                                BlendMode.modulate),
                            child: Image.asset('image/home.png')),
                    const SizedBox(height: 10),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: selectedPage == 0
                            ? Colors.black
                            : Colors.black.withOpacity(0.7),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _myPage!.jumpToPage(1);
                  setState(() {
                    selectedPage = 1;
                  });
                },
                child: Column(
                  children: [
                    selectedPage == 1
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.modulate),
                            child: Image.asset('image/profile.png'))
                        : ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.7),
                                BlendMode.modulate),
                            child: Image.asset('image/profile.png')),
                    const SizedBox(height: 10),
                    Text(
                      'My Account',
                      style: TextStyle(
                        color: selectedPage == 1
                            ? Colors.black
                            : Colors.black.withOpacity(0.7),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
