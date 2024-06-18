import 'package:flutter/material.dart';

class MedalCard extends StatefulWidget {
  const MedalCard(
      {super.key,
      required this.name,
      required this.description,
      required this.winners});
  final String name;
  final String description;
  final List<String> winners;

  @override
  State<MedalCard> createState() => _MedalCardState();
}

class _MedalCardState extends State<MedalCard> {
  bool winnersMode = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 200,
      child: Card(
        child: InkWell(
            onTap: () {
              setState(() {
                winnersMode = !winnersMode;
              });
            },
            child: winnersMode == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/medal.png',
                        width: 100,
                        height: 100,
                      ),
                      Text(widget.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Text(widget.description, textAlign: TextAlign.center),
                    ],
                  )
                : Column(
                    children: [
                      const Text('Ganadores:'),
                      for (int i = 0; i < widget.winners.length; i++)
                        Text(widget.winners[i]),
                    ],
                  )),
      ),
    );
  }
}
