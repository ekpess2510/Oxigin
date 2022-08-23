import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../Provider/auth_provider.dart';
import '../../repository/auth_repository.dart';
import 'Assessments/assessments.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _secureStorage = const FlutterSecureStorage();
  var length = 0;
  String? doc;


  getAssessment() async {
    var name = await _secureStorage.read(key: 'name');
    doc = name!.replaceAll(' ', '');
    FirebaseFirestore.instance
        .collection(name.replaceAll(' ', ''))
        .get()
        .then((value) {
      setState(() {
        length = value.docs.length;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAssessment();
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

    //super.build(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 70,
          ),
          FutureBuilder<DocumentSnapshot>(
              future: getInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: const CircleAvatar(
                            //backgroundImage: AssetImage('image/avatar.png'),
                            //backgroundColor: Colors.grey,
                            radius: 34,
                          ),
                        ),
                        Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: const SizedBox(
                              width: 100,
                              height: 30,
                            )),
                        const SizedBox(height: 10),
                        Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: const SizedBox(
                              width: 180,
                              height: 30,
                            )),
                        const SizedBox(height: 10),
                        Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: const SizedBox(
                              width: 180,
                              height: 30,
                            )),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(119, 184, 251, 1),
                                width: 2),
                            shape: BoxShape.circle,
                            // image: const DecorationImage(image: AssetImage('image/avatar.png'),
                            // fit: BoxFit.cover
                            // ),
                          ),
                          child: Center(
                            child: Image.asset('image/avatar.png'),
                          ),
                        ),
                        // const CircleAvatar(
                        //   backgroundImage: AssetImage('image/avatar.png'),
                        //   backgroundColor: Colors.grey,
                        //   //backgroundColor: Colors.grey,
                        //   radius: 34,
                        // ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data!['full_name'],
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('image/age.png'),
                            const SizedBox(width: 5),
                            Text(
                              snapshot.data!['age'],
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 20),
                            Image.asset('image/gender.png'),
                            const SizedBox(width: 5),
                            Text(
                              "${snapshot.data!['phone']}",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data!['email'],
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    );
                  }
                } else {
                  return Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: const CircleAvatar(
                          //backgroundImage: AssetImage('image/avatar.png'),
                          //backgroundColor: Colors.grey,
                          radius: 34,
                        ),
                      ),
                      Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: const SizedBox(
                            width: 100,
                            height: 30,
                          )),
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: const SizedBox(
                            width: 180,
                            height: 30,
                          )),
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: const SizedBox(
                            width: 180,
                            height: 30,
                          )),
                    ],
                  );
                }
              }),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              AuthRepositoryImpl().signOut(context);
            },
            child: Container(
              width: 94,
              height: 32,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(235, 87, 87, 1)),
              child: Text(
                'Log Out',
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Assessments(doc: doc!,);
                })));
              },
              child: Row(
                children: [
                  Text(
                    'My Assessments',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  Text(
                    '$length',
                    //getAssessment(),
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.arrow_forward_ios, color: Colors.black)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
