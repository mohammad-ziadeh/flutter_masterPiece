import 'package:flutter/material.dart';
import 'package:masterpiece_flutter/components/statistics.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Statistics(),
        SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Card(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/students');
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people, size: 50),
                              SizedBox(height: 20),
                              Text('Students', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Card(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {},
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.file_copy, size: 50),
                              SizedBox(height: 20),
                              Text(
                                'Submissions',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
