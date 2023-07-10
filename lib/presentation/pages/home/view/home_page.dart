import 'package:flutter/material.dart';

import '../../../../theme/theme_constants.dart';
import '../../explore/view/explore_page.dart';
import '../../my_tours/view/my_tours_page.dart';

class HomePage extends StatefulWidget {
  static const String route = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> pages = const [ExplorePage(), MyToursPage()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildNavBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
    );
  }

  Widget _buildNavBar() {
    double bottom = MediaQuery.paddingOf(context).bottom;
    double width = MediaQuery.sizeOf(context).width;

    List<String> labels = ["Explore", "My Tours"];
    List<IconData> icons = [
      Icons.south_america_outlined,
      Icons.list_alt_outlined
    ];

    return Container(
      margin: EdgeInsets.only(
        left: width * .2,
        right: width * .2,
        bottom: bottom,
      ),
      height: width * .17,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: primaryTextColor.withOpacity(0.25),
            offset: const Offset(0, 0),
            blurRadius: 8.0,
          )
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: width * .02),
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => setState(() {
            _currentIndex = index;
          }),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == _currentIndex ? width * .32 : width * .18,
                alignment: Alignment.centerRight,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: index == _currentIndex ? width * .12 : 0,
                  width: index == _currentIndex ? width * .32 : 0,
                  decoration: BoxDecoration(
                    color: index == _currentIndex
                        ? primaryColor.withOpacity(0.25)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == _currentIndex ? width * .31 : width * .18,
                alignment: Alignment.centerRight,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == _currentIndex ? width * .13 : 0,
                        ),
                        AnimatedOpacity(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          opacity: index == _currentIndex ? 1 : 0,
                          child: Text(
                            index == _currentIndex ? labels[index] : "",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == _currentIndex ? width * .03 : 20.0,
                        ),
                        Icon(icons[index]),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
