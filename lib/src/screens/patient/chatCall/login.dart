// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:pocket_pal/src/screens/patient/chatCall/home.dart';
// import 'package:pocket_pal/src/screens/patient/chatCall/likes.dart';

// class Login extends StatefulWidget {
//   Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   int _selectedIndex = 0;
//   List pages = [Home(), Likes(), Likes(), Likes()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages.elementAt(_selectedIndex),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             )),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//             child: GNav(
//               hoverColor: Colors.grey[100]!,
//               gap: 8,
//               activeColor: Colors.blue[300],
//               iconSize: 24,
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               duration: Duration(milliseconds: 400),
//               tabBackgroundColor: Colors.grey[100]!,
//               color: Colors.black,
//               tabs: [
//                 GButton(
//                   icon: Icons.home,
//                   text: 'Home',
//                 ),
//                 GButton(
//                   icon: Icons.thumb_up,
//                   text: 'Likes',
//                 ),
//                 GButton(
//                   icon: Icons.search,
//                   text: 'Search',
//                 ),
//                 GButton(
//                   icon: Icons.person,
//                   text: 'Profile',
//                 ),
//               ],
//               selectedIndex: _selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
