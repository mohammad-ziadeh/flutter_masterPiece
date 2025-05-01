import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for json decoding
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

String getServerUrl() {
  if (kIsWeb) {
    return 'http://127.0.0.1:8000'; 
  } else if (Platform.isAndroid) {
    return 'http://192.168.1.160:8000';
  } else {
    return 'http://127.0.0.1:8000'; 
  }
}
Future<List<dynamic>> fetchStudents() async {
  final response = await http.get(Uri.parse('${getServerUrl()}/api/students'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data.values.toList(); 
  } else {
    throw Exception('Failed to load students');
  }
}

class StudentsPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const StudentsPage({Key? key, required this.onToggleTheme}) : super(key: key);
  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFeeeeee),
        title: const Text('LMC', style: TextStyle(color: Color(0xFFeeeeee))),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to load students. Please try again.'),
            );
          } else {
            final students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Text(student['id'].toString()),
                    title: Text(
                      student['name'] ?? 'No Name',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(student['role'] ?? 'No Role'),
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
