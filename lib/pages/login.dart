import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: keyform,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter the email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text("Email"),
                          hintText: "example@example.com",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter the password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text("Password"),
                          hintText: "********",
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              const Color(0xFF3B1E54),
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (keyform.currentState!.validate()) {
                              Navigator.pushNamed(context, '/home');
                            } else {
                              print("login failed");
                            }
                          },
                          child: Text("Login"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(color: const Color(0xFF3B1E54)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: const Color(0xFF3B1E54),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final GlobalKey<FormState> keyform = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String _errorMessage = '';
//   bool _isLoading = false;

//   Future<void> _handleLogin() async {
//     if (!keyform.currentState!.validate()) return;

//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     final response = await http.post(
//       Uri.parse('http://127.0.0.1:8000/api/login'), 
//       body: {
//         'email': _emailController.text,
//         'password': _passwordController.text,
//       },
//     );

//     setState(() {
//       _isLoading = false;
//     });

//     if (response.statusCode == 200) {
//       // ignore: unused_local_variable
//       final responseData = json.decode(response.body);

//       Navigator.pushNamed(context, '/home');

//     } else if (response.statusCode == 403) {
//       setState(() {
//         _errorMessage = 'Access denied. Admins only.';
//       });
//     } else {
//       setState(() {
//         _errorMessage = 'Login failed. Please check your credentials.';
//       });
//     }
//   }

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
//                         controller: _emailController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please enter the email";
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
//                         controller: _passwordController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please enter the password";
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
//                       if (_errorMessage.isNotEmpty)
//                         Text(
//                           _errorMessage,
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       const SizedBox(height: 20),
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
//                           onPressed: _isLoading ? null : _handleLogin,
//                           child: _isLoading
//                               ? CircularProgressIndicator(color: Colors.white)
//                               : Text("Login"),
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
