import 'package:ecardio/view/Doctor.dart';
import 'package:ecardio/view/HomePage.dart';
import 'package:ecardio/view/ShopPage.dart';
import 'package:ecardio/view/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  void goToPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  List _pages = [HomePage(), ShopPage(), Doctor(), UserProfile()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  currentIndex = index;
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .0422,
                    left: size.width * .0422,
                  ),
                  width: size.width * .128,
                  height: index == currentIndex ? size.width * .014 : 0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34A77F),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                  listOfIcons[index],
                  size: size.width * .065,
                  color: index == currentIndex
                      ? Color(0xFF34A77F)
                      : Colors.black38,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }

   List<IconData> listOfIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.store,
    FontAwesomeIcons.userDoctor,
    FontAwesomeIcons.idBadge
  ];
}

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[currentIndex],
//       bottomNavigationBar: GNav(
//           onTabChange: (index) => goToPage(index),
//           tabBorderRadius: 50,
//           tabActiveBorder: Border.all(color: Colors.black, width: 1),
//           curve: Curves.easeInOut, // tab animation curves
//           duration: Duration(milliseconds: 500),
//           tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 1.5)], // tab animation duration
//           gap: 8, // the tab button gap between icon and text
//           activeColor: const Color(0xFF34A77F), // selected icon and text color
//           iconSize: 20, // tab button icon size
//           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//           tabs: const [
//             GButton(
//               icon: FontAwesomeIcons.house,
//               text: 'Home',
//             ),
//             GButton(
//               icon: FontAwesomeIcons.store,
//               text: 'Shop',
//             ),
//             GButton(
//               icon: FontAwesomeIcons.userDoctor,
//               text: 'Book',
//             ),
//             GButton(
//               icon: FontAwesomeIcons.userAstronaut,
//               text: 'Profile',
//             ),
//           ]),
//     );
//   }
// }

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//    int currentPageIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         // indicatorColor: Colors.g,
//         indicatorShape: ,
//         backgroundColor: Colors.white,
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         selectedIndex: currentPageIndex,
//         destinations:
//         const [
//           NavigationDestination(icon: Icon(FontAwesomeIcons.houseMedical, color: Color(0xFF34A77F),), label: 'Home'),
//           NavigationDestination(icon: Icon(FontAwesomeIcons.store, color: Color(0xFF34A77F) ,), label: 'Shop'),
//           NavigationDestination(icon: Icon(FontAwesomeIcons.userDoctor, color: Color(0xFF34A77F) ,), label: 'Book'),
//           NavigationDestination(icon: Icon(FontAwesomeIcons.userAstronaut, color: Color(0xFF34A77F)), label: 'Profile'),

//         ]
//       ),
//     );
//   }
// }

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {

//   int _selectedIndex = 0;

//   void _navigateBottomBar(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   final List<Widget> _pages = [
//     const HomePage(),
//     const ShopPage(),
//     const Doctor(),
//     const UserProfile(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:Colors.white,
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(

//           currentIndex: _selectedIndex,
//           onTap: _navigateBottomBar,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.houseMedical, color: Color(0xFF34A77F)), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.store, color: Color(0xFF34A77F),), label: 'Shop'),
//             BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userDoctor, color: Color(0xFF34A77F),), label: 'Book'),
//             BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userAstronaut, color: Color(0xFF34A77F),), label: 'Profile'),

//           ]),
//     );
//   }
// }
