import 'package:flutter/material.dart';

import '../Profile/profile.dart';

class NavigationBottomBar extends StatefulWidget {
  final Widget screen;

  const NavigationBottomBar({Key? key, required this.screen}) : super(key: key);

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _myPage,
        children: [widget.screen, const ProfileScreen()],
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
