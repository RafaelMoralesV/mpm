import 'package:flutter/material.dart';
import 'package:mpmagic/components/basic_button.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Center(
          child: Text("Perfil", style: TextStyle(fontSize: 60)),
        ),
        BasicButton(
          link: "https://github.com/RafaelMoralesV/mpm",
          buttonText: "GitHub",
          iconPath: "assets/icons/github.png",
          colors: [
            Colors.black,
            Colors.black,
          ],
        ),
      ],
    );
  }
}
