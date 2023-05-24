import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/tours/tours.dart';
import '../../../../theme/theme_constants.dart';
import '../../../my_tours/view/my_tours_page.dart';
import '../../explore/view/explore_page.dart';

class HomePage extends StatefulWidget {
  static const String route = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> pages = const [ExplorePage(), MyToursPage()];

  late ToursBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
    bloc.add(ToursLoadAll());
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
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: primaryTextColor.withOpacity(0.2),
              offset: const Offset(0, 0),
              blurRadius: 8.0,
            )
          ]),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 0.0,
        fixedColor: primaryTextColor,
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
        ),
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.south_america_outlined),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage_outlined),
            label: "My tours",
          ),
        ],
      ),
    );
  }
}
