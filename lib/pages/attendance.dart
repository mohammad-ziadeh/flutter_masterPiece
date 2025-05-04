import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final String apiUrl = "http://127.0.0.1:8000/api/attendance";
  final String postUrl = "http://127.0.0.1:8000/api/attendance/store";

  List<dynamic> users = [];
  Map<int, String> attendance = {};

  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          users = data['users'] ?? [];

          // Filter only students
          users = users.where((user) => user['role'] == 'student').toList();

          var attendancesData = data['attendances'] ?? {};

          for (var user in users) {
            int userId = user['id'];
            String status =
                attendancesData[userId.toString()]?['status'] ?? 'absent';
            attendance[userId] = status;
          }

          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      print("Fetch error: $e");
    }
  }

  Future<void> submitAttendance() async {
    try {
      final response = await http.post(
        Uri.parse(postUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'attendances': safeMapConvert(attendance)}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Attendance saved successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error saving data: ${response.statusCode} - ${response.reasonPhrase}',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Network error: $e')));
      print("Submit error: $e");
    }
  }

  Map<String, dynamic> safeMapConvert(Map<int, dynamic>? map) {
    Map<String, dynamic> result = {};
    if (map == null) return result;

    map.forEach((key, value) {
      if (value == null) {
        result[key.toString()] = null;
      } else if (value is Map) {
      } else {
        result[key.toString()] = value;
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : hasError
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Please check your connection and try again."),
                    ],
                  ),
                )
                : users.isEmpty
                ? Center(
                  child: Text(
                    "No students found.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
                : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final userId = user['id'];
                    final userName = user['name'];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$userName",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButton<String>(
                                value: attendance[userId],
                                onChanged: (value) {
                                  setState(() {
                                    attendance[userId] = value!;
                                  });
                                },
                                items:
                                    ['present', 'absent', 'late'].map((status) {
                                      return DropdownMenuItem<String>(
                                        value: status,
                                        child: Text(
                                          capitalize(status),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: submitAttendance,
        label: Text("Save All"),
        icon: Icon(Icons.save),
        tooltip: "Save Attendance",
      ),
    );
  }

  String capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';
}
