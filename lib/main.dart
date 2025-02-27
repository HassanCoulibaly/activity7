import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;  // Local state to manage dark mode

  void toggleTheme(bool isOn) {
    setState(() {
      _isDarkMode = isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: FadingTextAnimation(
        onThemeChanged: toggleTheme,
        isDarkMode: _isDarkMode,  // Pass the current theme state down
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const FadingTextAnimation({Key? key, required this.onThemeChanged, required this.isDarkMode}) : super(key: key);

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  bool _showFrame = false;

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
            value: widget.isDarkMode,  // Use local state to set the Switch value
            onChanged: widget.onThemeChanged,
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
          mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }
}
