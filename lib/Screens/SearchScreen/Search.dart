import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Constant/selected_list.dart';
import '../../Model/search_model.dart';
import '../../Provider/api_provider.dart';
import '../Assesment/picked_symptoms.dart';
import '../Shared/expanded_list_tile.dart';
import 'controller/search_controller.dart';

class Search extends ConsumerStatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(searchNotifier);
    final data = ref.watch(searchDataProvider);
    return Scaffold(
      backgroundColor: HexColor('ffffff'),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Text('',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor('121212'),
              )),
        ),
        backgroundColor: HexColor('ffffff'),
        elevation: 0,
      ),
      body: data.when(
        data: (data) {
          List<SearchModel> lists = data;
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Search for a symptom.',
                              style: TextStyle(
                                fontFamily: 'Recoleta',
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 22),
                          child: SizedBox(
                              height: 52,
                              child: TextFormField(
                                controller: searchController,
                                onFieldSubmitted: (value) {
                                  if (selectedItems.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Select at least a symptom')));
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                      return const PickedSystoms();
                                    })));
                                  }
                                },
                                textInputAction: TextInputAction.done,
                                onChanged: (String value) {
                                  controller.searchOperation(value, lists);
                                },
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    label: const Text('E.g headache'),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                onTap: () {
                                  setState(() {
                                    controller.searchItems.clear();
                                    controller.isSearching = true;
                                  });
                                  print(controller.isSearching);
                                },
                              )),
                        ),
                        controller.searchItems.isNotEmpty
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                //height: 300,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.searchItems.length,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: ((context, index) {
                                      print(controller.searchItems[index].name);
                                      return ExpandedSearchTile(
                                        title:
                                            controller.searchItems[index].name,
                                        subTitle: controller
                                            .searchItems[index].commonName,
                                        onTap: () {
                                          controller.symptonSelected(controller
                                              .searchItems[index]);
                                        },
                                      );
                                    })),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (err, s) => Center(
          child: Text(err.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
