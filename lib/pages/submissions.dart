import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:masterpiece_flutter/components/submissionDetails.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

// Server URL function
String getServerUrl() {
  if (kIsWeb) {
    return 'http://127.0.0.1:8000';
  } else if (Platform.isAndroid) {
    return 'http://192.168.1.160:8000'; 
  } else {
    return 'http://127.0.0.1:8000';
  }
}

Future<List<dynamic>> fetchSubmissions() async {
  final response = await http.get(Uri.parse('${getServerUrl()}/api/submissions'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load submissions');
  }
}

class SubmissionsPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const SubmissionsPage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<SubmissionsPage> createState() => _SubmissionsPageState();
}

class _SubmissionsPageState extends State<SubmissionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        foregroundColor: const Color(0xFFeeeeee),
        title: const Text('Submissions', style: TextStyle(color: Color(0xFFeeeeee))),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchSubmissions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load submissions.'));
          } else {
            final submissions = snapshot.data!;
            return ListView.builder(
              itemCount: submissions.length,
              itemBuilder: (context, index) {
                final submission = submissions[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(submission['id'].toString())),
                    title: Text(submission['user']['name'] ?? 'Unknown User'),
                    trailing: Text(submission['grade']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubmissionDetailPage(
                            submissionId: submission['id'],
                          ),
                        ),
                      );
                    },
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
