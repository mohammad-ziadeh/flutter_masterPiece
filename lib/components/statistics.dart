import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

String getServerUrl() {
  if (kIsWeb) {
    return 'http://127.0.0.1:8000'; // for Web
  } else if (Platform.isAndroid) {
    return 'http://192.168.1.160:8000'; // adjust to your local IP
  } else {
    return 'http://127.0.0.1:8000'; // for iOS/macOS
  }
}

Future<Map<String, dynamic>> fetchStatistics() async {
  final response = await http.get(
    Uri.parse('${getServerUrl()}/api/statistics'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load statistics');
  }
}

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  int totalAbsent = 0;
  int totalLate = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    try {
      final stats = await fetchStatistics();
      setState(() {
        totalAbsent = stats['totalAbsent'];
        totalLate = stats['totalLate'];
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

if (isLoading) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Center(child: CircularProgressIndicator()),
  );
}

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 160,
          width: 160,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 60),
                Text('Today Absences', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('$totalAbsent', style: TextStyle(fontSize: 40)),
              ],
            ),
          ),
        ),
        SizedBox(width: screenWidth > 600 ? 100 : 40),
        Container(
          width: 160,
          height: 160,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 60),
                Text('Today Latency', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('$totalLate', style: TextStyle(fontSize: 40)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



