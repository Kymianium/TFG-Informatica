// ignore_for_file: prefer_const_constructors
import '/widgets/medal_view.dart';
import '/models/medals.dart';

import 'package:flutter/material.dart';

class ConsultMedals extends StatefulWidget {
  const ConsultMedals({super.key});

  @override
  State<ConsultMedals> createState() => _ConsultMedalsState();
}

// A scrolling list of medals in medalCollection
class _ConsultMedalsState extends State<ConsultMedals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de medallas'), centerTitle: true),
      body: Center(
        child: SizedBox(
            width: 1000,
            child: ListView(children: [
              Column(children: [
                for (int i = 0; i < medalCollection.length; i += 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MedalCard(
                        name: medalCollection[i].name,
                        description: medalCollection[i].description,
                        winners: medalCollection[i].winners,
                      ),
                      if (i + 1 < medalCollection.length)
                        MedalCard(
                          name: medalCollection[i + 1].name,
                          description: medalCollection[i + 1].description,
                          winners: medalCollection[i + 1].winners,
                        ),
                      if (i + 2 < medalCollection.length)
                        MedalCard(
                          name: medalCollection[i + 2].name,
                          description: medalCollection[i + 2].description,
                          winners: medalCollection[i + 2].winners,
                        ),
                    ],
                  )
              ])
            ])),
      ),
    );
  }
}
