import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  bool _showFrame = false;
  bool _darkMode = false;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: <Widget>[
          Switch(
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
                (context as Element).markNeedsBuild();  // Forces the parent widget to rebuild with the new theme.
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: _showFrame ? BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 5,
            ),
          ) : null,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(seconds: 1),
            child: Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Text('Show Frame'),
            Switch(
              value: _showFrame,
              onChanged: (bool value) {
                setState(() {
                  _showFrame = value;
                });
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
