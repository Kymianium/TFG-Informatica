import 'package:flutter/material.dart';

class HomepageButton extends StatelessWidget {
  final String image;
  final String text;
  final String route;

  const HomepageButton(
      {required this.image,
      required this.text,
      required this.route,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 100,
              height: 100,
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}

