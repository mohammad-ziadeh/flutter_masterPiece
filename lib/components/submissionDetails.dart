import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String getServerUrl() {
  if (kIsWeb) {
    return 'http://127.0.0.1:8000';
  } else if (Platform.isAndroid) {
    return 'http://192.168.1.160:8000';
  } else {
    return 'http://127.0.0.1:8000';
  }
}

class SubmissionDetailPage extends StatefulWidget {
  final int submissionId;

  const SubmissionDetailPage({Key? key, required this.submissionId}) : super(key: key);

  @override
  State<SubmissionDetailPage> createState() => _SubmissionDetailPageState();
}

class _SubmissionDetailPageState extends State<SubmissionDetailPage> {
  Map<String, dynamic>? submission;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchSubmissionDetail();
  }

  Future<void> fetchSubmissionDetail() async {
    try {
      final response = await http.get(Uri.parse('${getServerUrl()}/api/submissions/${widget.submissionId}'));

      if (response.statusCode == 200) {
        setState(() {
          submission = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Submission not found';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching submission data';
        isLoading = false;
      });
    }
  }

  void _launchPDF(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open PDF')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Submission Detail')),
        body: Center(child: Text(errorMessage!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Submission Detail'),
        foregroundColor: const Color(0xFFeeeeee),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: screenWidth > 600 ? 590 : 390,
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow('Student:', submission!['user']['name'] ?? 'N/A'),

                const SizedBox(height: 20),
                _buildRow('Answer:', submission!['answer'] ?? 'No answer provided'),
                const SizedBox(height: 20),
                _buildRow('Grade:', submission!['grade']?.toString() ?? 'N/A'),
                const SizedBox(height: 30),

                if (submission!['pdf_path'] != null)
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text('View PDF File'),
                      onPressed: () {
                        final pdfUrl = '${getServerUrl()}/storage/${submission!['pdf_path']}';
                        _launchPDF(pdfUrl);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B1E54),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B1E54),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF3B1E54),
            ),
          ),
        ),
      ],
    );
  }
}
