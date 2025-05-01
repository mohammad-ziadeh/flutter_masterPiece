// import 'package:flutter/material.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   GlobalKey<FormState> keyform = GlobalKey<FormState>();
//   String? password;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Form(
//                 key: keyform,
//                 child: Padding(
//                   padding: const EdgeInsets.all(30.0),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "please enter you Username";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           label: Text("Username"),
//                           hintText: "Your name",
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "please enter the email";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           label: Text("Email"),
//                           hintText: "example@example.com",
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         onChanged: (value) => password = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "please enter the password";
//                           }
//                           return null;
//                         },
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           label: Text("Password"),
//                           hintText: "********",
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please confirm your password";
//                           }
//                           if (value != password) {
//                             return "The passwords does not match";
//                           }
//                           return null;
//                         },
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           label: Text("Confirm Password"),
//                           hintText: "********",
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       SizedBox(
//                         width: 120,
//                         height: 50,
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor: WidgetStateProperty.all(
//                               const Color(0xFF3B1E54),
//                             ),
//                             foregroundColor: WidgetStateProperty.all(
//                               Colors.white,
//                             ),
//                           ),
//                           onPressed: () {
//                             if (keyform.currentState!.validate()) {
//                               Navigator.pushNamed(context, '/login');
//                               //   print(password);
//                             } else {
//                               print("login failed");
//                             }
//                           },
//                           child: Text("Sign up"),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 50),
//                         child: Row(
//                           children: [
//                             Text(
//                               "Already have an account?",
//                               style: TextStyle(color: const Color(0xFF3B1E54)),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushNamed(context, '/login');
//                               },
//                               child: Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   color: const Color(0xFF3B1E54),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
