import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Provider/auth_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>  with AutomaticKeepAliveClientMixin<ProfileScreen> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    final data = ref.watch(fireBaseAuthProvider);

    Future<DocumentSnapshot> getInfo() async {
      var fireStore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
      await fireStore.collection('users').doc(data.currentUser!.uid).get();
      return snapshot;
    }

    super.build(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('image/avatar.png'),
            //backgroundColor: Colors.grey,
            radius: 34,
          ),
          Text(
            'Emmanuel Ekpenyong',
            style: GoogleFonts.inter(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('image/age.png'),
              const SizedBox(width: 5),
              Text(
                '19 Years',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              const SizedBox(width: 20),
              Image.asset('image/gender.png'),
              const SizedBox(width: 5),
              Text(
                'Male',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'ekpenyong2510@gmail.com',
            style: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          const SizedBox(height: 15),
          Container(
            width: 94,
            height: 32,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
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
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                  '8',
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

        ],
      ),
    );
  }
}
