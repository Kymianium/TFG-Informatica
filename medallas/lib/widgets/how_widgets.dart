import 'package:flutter/material.dart';
import '/models/challenges.dart';
import '/models/medals.dart';

class ChallengeCondition extends StatefulWidget {
  ChallengeCondition(this.position, {super.key});
  int position;

  @override
  State<ChallengeCondition> createState() => _ChallengeConditionState();
}

// Three dropdown buttons should let the user choose:
// the name, from a list containing "any" and all the names in challengeCollection
// the competence, from a list of six competences
// the conditions (use little time, hints, attempts...)
class _ChallengeConditionState extends State<ChallengeCondition> {
  String name = "Cualquiera";
  String competence = "Cualquiera";
  String conditions = "Cualquiera";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Resolver un reto que cumpla...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text("Nombre",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: name,
                  onChanged: (String? newValue) {
                    setState(() {
                      name = newValue!;
                      currentMedal.how[widget.position] =
                          "ch/$name/$competence/$conditions";
                    });
                  },
                  items: <String>[
                    'Cualquiera',
                    for (var challenge in challengeCollection) challenge.name
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Column(
              children: [
                const Text("Competencia",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: competence,
                  onChanged: (String? newValue) {
                    setState(() {
                      competence = newValue!;
                      currentMedal.how[widget.position] =
                          "ch/$name/$competence/$conditions";
                    });
                  },
                  items: <String>[
                    'Cualquiera',
                    'Blockchain',
                    'Crypto',
                    'Forensics',
                    'Gamepwn',
                    'Hardware',
                    'Web',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Column(
              children: [
                const Text("Condiciones",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: conditions,
                  onChanged: (String? newValue) {
                    setState(() {
                      conditions = newValue!;
                      currentMedal.how[widget.position] =
                          "ch/$name/$competence/$conditions";
                    });
                  },
                  items: <String>[
                    'Cualquiera',
                    'Pocas pistas',
                    'Poco tiempo',
                    'Pocos intentos',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class StatsCondition extends StatefulWidget {
  StatsCondition(this.position, {super.key});
  int position;

  @override
  State<StatsCondition> createState() => _StatsConditionState();
}

// A text that says "Llegar a _____ puntos en (competencia)", where the user
// can input a number in _____ and choose a competence from a dropdown button
class _StatsConditionState extends State<StatsCondition> {
  String points = "0";
  String competence = "Cualquiera";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Llegar a",
        ),
        SizedBox(
          width: 50,
          child: TextField(
            onChanged: (String value) {
              points = value;
              currentMedal.how[widget.position] = "st/$points/$competence";
            },
          ),
        ),
        const Text(
          "puntos en la competencia ",
        ),
        DropdownButton<String>(
          value: competence,
          onChanged: (String? newValue) {
            setState(() {
              competence = newValue!;
              currentMedal.how[widget.position] = "st/$points/$competence";
            });
          },
          items: <String>[
            'Cualquiera',
            'Blockchain',
            'Crypto',
            'Forensics',
            'Gamepwn',
            'Hardware',
            'Web',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class MedalCondition extends StatefulWidget {
  MedalCondition(this.position, {super.key});
  int position;

  @override
  State<MedalCondition> createState() => _MedalConditionState();
}

class _MedalConditionState extends State<MedalCondition> {
  String medal = medalCollection[0].name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Obtener la medalla "),
        DropdownButton<String>(
            value: medal,
            onChanged: (String? newValue) {
              setState(() {
                medal = newValue!;
                currentMedal.how[widget.position] = "md/$medal";
              });
            },
            items: [
              for (var i = 0; i < medalCollection.length; i++)
                DropdownMenuItem<String>(
                  value: medalCollection[i].name,
                  child: Text(medalCollection[i].name),
                ),
            ]),
      ],
    );
  }
}

class FrontCondition extends StatefulWidget {
  FrontCondition(this.position, {super.key});
  int position;

  @override
  State<FrontCondition> createState() => _FrontConditionState();
}

class _FrontConditionState extends State<FrontCondition> {
  String action = '1';
  List<String> actions = [
    'Consultar perfil',
    'Iniciar sesión',
    'Ver medallas',
    'Ver estadísticas',
    'Ver el perfil de otro usuario',
  ];
  @override
  Widget build(BuildContext context) {
    // DropdownButton with some interactions with the front
    // ("Consultar perfil", "Iniciar sesión"...)
    return DropdownButton<String>(
        value: action,
        onChanged: (String? newValue) {
          setState(() {
            action = newValue!;
            currentMedal.how[widget.position] = "front/$newValue";
          });
        },
        // The value of the action should be its index in the array
        items: [
          for (var i = 0; i < actions.length; i++)
            DropdownMenuItem<String>(
              value: i.toString(),
              child: Text(actions[i]),
            ),
        ]);
  }
}
