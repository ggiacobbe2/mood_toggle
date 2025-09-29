import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: MyApp(),
    ),
  );
}

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  String _currentMood = 'assets/happy_face.png';
  Color _backgroundColor = Colors.green;

  int _happyCount = 0;
  int _sadCount = 0;
  int _excitedCount = 0;

  String get currentMood => _currentMood;
  Color get backgroundColor => _backgroundColor;

  int get happyCount => _happyCount;
  int get sadCount => _sadCount;
  int get excitedCount => _excitedCount;

  void setHappy() {
    _currentMood = 'assets/happy_face.png';
    _backgroundColor = Colors.green;
    _happyCount++;
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'assets/sad_face.png';
    _backgroundColor = Colors.blue;
    _sadCount++;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'assets/shocked_face.png';
    _backgroundColor = Colors.yellow;
    _excitedCount++;
    notifyListeners();
  }

  void randomMood() {
    int randomIndex = Random().nextInt(3);
    if (randomIndex == 0) {
      setHappy();
    } else if (randomIndex == 1) {
      setSad();
    } else {
      setExcited();
    }
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Mood Toggle Challenge')),
          body: Container(
            color: moodModel.backgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('How are you feeling?', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 30),
                  MoodDisplay(),
                  SizedBox(height: 50),
                  MoodButtons(),
                  SizedBox(height: 30),
                  MoodCounters(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Image.asset(
          moodModel.currentMood,
          width: 300,
          height: 300,
        );
      },
    );
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
          child: Text('Happy :D'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
          child: Text('Sad :('),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
          child: Text('Shocked :O'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).randomMood();
          },
          child: Text('Random!'),
        ),
      ],
    );
  }
}

// Widget to display mood counters
class MoodCounters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Column(
          children: [
            Text('Happy Times: ${moodModel.happyCount}', style: TextStyle(fontSize: 18)),
            Text('Sad Times: ${moodModel.sadCount}', style: TextStyle(fontSize: 18)),
            Text('Excited Times: ${moodModel.excitedCount}', style: TextStyle(fontSize: 18)),
          ],
        );
      },
    );
  }
}