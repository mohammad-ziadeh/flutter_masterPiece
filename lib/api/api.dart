import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for json decoding
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

String getServerUrl() {
  if (kIsWeb) {
    return 'http://127.0.0.1:8000'; // for Web (Chrome, etc.)
  } else if (Platform.isAndroid) {
    return 'http://192.168.1.160:8000'; // for Android Emulator
  } else {
    return 'http://127.0.0.1:8000'; // for iOS Simulator, Windows, Mac
  }
}

Future<List<dynamic>> fetchUsers() async {
  final response = await http.get(Uri.parse('${getServerUrl()}/api/users'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);

  } else {
    throw Exception('Failed to load products');
  }
}

void main() {
  runApp(MaterialApp(title: 'Flutter CRUD App', home: UsersPage()));
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User')),
      body: FutureBuilder<List<dynamic>>(
        //future builder special widget to fetch data take two prameters future , builder
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Text(user['id'].toString()), // Display the room ID
                    title: Text(
                      user['name'] ?? 'No Name',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(user['role'] ?? 'No Role'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
