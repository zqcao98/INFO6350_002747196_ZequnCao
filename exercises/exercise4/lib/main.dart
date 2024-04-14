import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MaterialApp(home: MainMenu()));
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero Animation Demos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _showStandardAnimations(context),
              child: Text('Standard Hero Animations'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showRadialAnimations(context),
              child: Text('Radial Hero Animations'),
            ),
          ],
        ),
      ),
    );
  }

  void _showStandardAnimations(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Text('Select Standard Animation'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StandardHeroAnimation(emoji: '🐶', size: 300.0),
                ),
              );
            },
            child: Text('Standard Animation - Dog'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StandardHeroAnimation(emoji: '🐼', size: 400.0),
                ),
              );
            },
            child: Text('Standard Animation - Panda'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StandardHeroAnimation(emoji: '🐻', size: 350.0),
                ),
              );
            },
            child: Text('Standard Animation - Bear'),
          ),
        ],
      ),
    );
  }

  void _showRadialAnimations(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Text('Select Radial Animation'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RadialHeroAnimation(emoji: '🐱', radius: 100.0),
                ),
              );
            },
            child: Text('Radial Animation - Cat'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RadialHeroAnimation(emoji: '🐸', radius: 150.0),
                ),
              );
            },
            child: Text('Radial Animation - Frog'),
          ),
        ],
      ),
    );
  }
}

class StandardHeroAnimation extends StatelessWidget {
  final String emoji;
  final double size;

  StandardHeroAnimation({required this.emoji, required this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Standard Hero Animation')),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(emoji: emoji, size: size)),
          );
        },
        child: Hero(
          tag: emoji,
          child: Text(emoji, style: TextStyle(fontSize: 80)),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String emoji;
  final double size;

  DetailScreen({required this.emoji, required this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Hero(
          tag: emoji,
          child: Text(emoji, style: TextStyle(fontSize: size)),
        ),
      ),
    );
  }
}

class RadialHeroAnimation extends StatelessWidget {
  final String emoji;
  final double radius;

  RadialHeroAnimation({required this.emoji, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radial Hero Animation')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              _createRoute(),
            );
          },
          child: Hero(
            tag: emoji,
            child: ClipOval(
              child: Container(
                width: radius,
                height: radius,
                alignment: Alignment.center,
                child: Text(emoji, style: TextStyle(fontSize: radius / 2)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailRadialPage(emoji: emoji, radius: radius * 2),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.ease);
        return ScaleTransition(scale: curvedAnimation, child: child);
      },
    );
  }
}

class DetailRadialPage extends StatelessWidget {
  final String emoji;
  final double radius;

  DetailRadialPage({required this.emoji, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Radial Page'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Hero(
            tag: emoji,
            child: Container(
              width: radius,
              height: radius,
              alignment: Alignment.center,
              child: Text(emoji, style: TextStyle(fontSize: radius / 2)),
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialClipper extends CustomClipper<Rect> {
  final double progress;

  _RadialClipper({required this.progress});

  @override
  Rect getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width, size.height) / 2 * progress;
    return Rect.fromCircle(center: center, radius: radius);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
