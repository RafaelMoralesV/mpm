import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicButton extends StatelessWidget {
  final String link, buttonText, iconPath;
  final List<Color> colors;
  const BasicButton({
    Key? key,
    required this.link,
    required this.buttonText,
    required this.iconPath,
    this.colors = const [Colors.pink, Colors.purple],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(1.5),
                child: Image.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            TextButton(
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () => launch(link),
            ),
          ],
        ),
      ),
    );
  }
}
