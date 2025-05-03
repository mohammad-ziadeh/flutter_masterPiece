import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flame_audio/flame_audio.dart';

class SpinningWheel extends StatefulWidget {
  const SpinningWheel({super.key});

  @override
  State<SpinningWheel> createState() => _SpinningWheelState();
}

class _SpinningWheelState extends State<SpinningWheel> {
  final StreamController<int> controller = StreamController<int>.broadcast();
  int? selectedIndex;

  final TextEditingController nameController = TextEditingController();

  final List<String> students = [
    'participant 1',
    'participants 2',
    'participants 3',
  ];

  @override
  void dispose() {
    controller.close();
    nameController.dispose();
    super.dispose();
  }

  void addStudent() {
    final newName = nameController.text.trim();
    if (newName.isNotEmpty && !students.contains(newName)) {
      setState(() {
        students.add(newName);
      });
      nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Enter a name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: addStudent,
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      elevation: 5,
                      child: FortuneWheel(
                        selected: controller.stream,
                        animateFirst: false,
                        hapticImpact: HapticImpact.light,
                        indicators: const [
                          FortuneIndicator(
                            alignment: Alignment.topCenter,
                            child: TriangleIndicator(
                              color: Color(0xFF3b1e54),
                              elevation: 5,
                            ),
                          ),
                        ],
                        items: [
                          ...students.map(
                            (student) => FortuneItem(child: Text(student)),
                          ),
                        ],
                        onFling: () {
                          FlameAudio.play('spin-232536.mp3', volume: 0.8);
                          selectedIndex = Fortune.randomInt(0, students.length);
                          controller.add(selectedIndex!);
                        },
                        onAnimationEnd: () {
                          if (selectedIndex != null &&
                              selectedIndex! < students.length) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Result 🎉',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    '${students[selectedIndex!]} has been selected!',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                      child: const Text('Done'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    FlameAudio.play('spin-232536.mp3', volume: 0.8);
                    selectedIndex = Fortune.randomInt(0, students.length);
                    controller.add(selectedIndex!);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                  ),
                  child: const Text('Spin'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Participants:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (students.length < 3) ...[
                  const Text(
                    'The minimum number of participants is 2',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    if (students.length >= 3) {
                      return Dismissible(
                        key: Key(students[index]),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            students.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Removed ${students[index]}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          title: Text(students[index]),
                          trailing: const Icon(Icons.swipe_left_outlined),
                        ),
                      );
                    } else {
                      return ListTile(
                        title: Text(students[index]),
                        trailing: const Icon(Icons.swipe_left_outlined),
                      );
                    }
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
