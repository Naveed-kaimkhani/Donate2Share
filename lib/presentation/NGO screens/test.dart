// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool _isButtonVisible = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Centered Floating Action Button')),
//       body: Center(child: Text('Content goes here')),
//       floatingActionButton: Visibility(
//         visible: _isButtonVisible,
//         child: CenteredFloatingActionButton(
//           onPressed: () {
//             // Floating Action Button Action
//             print('Floating Action Button Pressed');
//           },
//           child: Icon(Icons.add),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       bottomNavigationBar: BottomAppBar(
//         child: Container(height: 50.0),
//       ),
//     );
//   }
// }
