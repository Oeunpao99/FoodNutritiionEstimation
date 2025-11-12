// import 'package:flutter/material.dart';
// import 'package:fnapp/providers/user_provider.dart';
// import 'package:provider/provider.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     _usernameController.text = userProvider.userName;
//     _emailController.text = userProvider.email;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(labelText: 'Username'),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 userProvider.setUser(
//                   _usernameController.text,
//                   _emailController.text,
//                 );
//                 Navigator.pop(context); // Go back to MyAccountScreen
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueAccent,
//                 padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: const Text(
//                 'Save Changes',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
