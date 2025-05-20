import 'package:flutter/material.dart';

class StudentDetailPage extends StatelessWidget {
  final Map<String, dynamic> student;

  const StudentDetailPage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(student['name'] ?? 'Student Details'),
        foregroundColor: Color(0xFFeeeeee),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                backgroundImage: AssetImage('images/unknowpfp.png'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: screenWidth > 600 ? 590 : 390,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B1E54),
                      ),
                    ),
                    Text(
                      ' ${student['name'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 18, color: Color(0xFF3B1E54)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      Text(
                        'ID:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B1E54),
                        ),
                      ),
                      Text(
                        ' ${student['id'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3B1E54),
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      Text(
                        'Email: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B1E54),
                        ),
                      ),
                      Text(
                        '${student['email'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3B1E54),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      Text(
                        'Weekly Points: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B1E54),
                        ),
                      ),
                      Text(
                        '${student['weekly_points'] ?? '0'}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3B1E54),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      Text(
                        'Joining Date: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B1E54),
                        ),
                      ),
                      Text(
                        '${student['created_at']?.split("T")[0] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3B1E54),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



