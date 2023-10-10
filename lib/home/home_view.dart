import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isfillSan = false;
  Duration duration = const Duration(seconds: 2);
  @override
  void initState() {
    super.initState();
    changeMode(0);
  }

  Future<void> changeMode(int value) async {
    await Future<void>.delayed(duration);
    if (value == 0) {
      setState(() {
        isfillSan = true;
      });
    } else {
      setState(() {
        isfillSan = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColor = [
      const Color(0xff922a7f),
      const Color(0xffce577d),
      const Color(0xffff9484),      
      if (isfillSan) const Color(0xffff9080),
    ];
    var darkBgColor = [
      const Color(0xff0f1746),
      const Color(0xff263280),
      const Color(0xff33519a),
    ];
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedContainer(
        duration: duration,
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isfillSan ? lightBgColor : darkBgColor),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: duration,
              left: 40,
              right: -40,
              bottom: isfillSan ? 390 : -80,
              child: SvgPicture.asset(
                '/Sun.svg',
                height: height * 0.5,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -48,
              child: Image.asset(
                '/land_tree_light.png',
                height: height * 0.9,
                width: width * 0.9,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: width * 0.8,
              height: 50,
              margin: const EdgeInsets.fromLTRB(50, 100, 10, 00),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  labelStyle:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                  tabs: const [
                    Tab(
                      text: 'Morning Login',
                    ),
                    Tab(
                      text: 'Night Login',
                    ),
                  ],
                  onTap: (value) async {
                    await changeMode(value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
