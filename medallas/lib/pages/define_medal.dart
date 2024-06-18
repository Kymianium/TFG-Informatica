// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/when_widgets.dart';
import '/widgets/how_widgets.dart';
import '/providers/when_provider.dart';
import '/models/medals.dart';
import '/network/manager.dart';
import 'dart:convert';

class DefineMedal extends StatefulWidget {
  const DefineMedal({super.key});

  @override
  State<DefineMedal> createState() => _DefineMedalState();
}

class _DefineMedalState extends State<DefineMedal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Definir medalla',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[350],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // What
                what(),
                // When
                when(),
                // How
                how(),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<WhenModel>(builder: (context, whenModel, child) {
                return ElevatedButton(
                  onPressed: () {
                    medalCollection.add(currentMedal);
                    Manager().channel.sink.add(jsonEncode(currentMedal));
                    currentMedal = Medal("", "Rojo", "", [""],
                        ["ch/Cualquiera/Cualquiera/Cualquiera"]);
                    whenModel.selectedIndexes = [0];
                    whenModel.challengeIndexes = [0];
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Guardar medalla',
                  ),
                );
              }))
        ],
      ),
    );
  }

  Consumer<WhenModel> when() {
    return Consumer<WhenModel>(builder: (context, whenModel, child) {
      return Column(
        children: [
          Text('¿Cuándo?',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              for (var i = 0; i < whenModel.selectedIndexes.length; i++)
                SizedBox(
                  height: 150,
                  width: 350,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                currentMedal.when[i] = "";
                                whenModel.updateIndex(i, 0);
                              },
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    whenModel.selectedIndexes[i] == 0
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                              child: const Text("Único")),
                          TextButton(
                              onPressed: () {
                                currentMedal.when[i] = "1/días";
                                whenModel.updateIndex(i, 1);
                              },
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    whenModel.selectedIndexes[i] == 1
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                              child: const Text("Periódico")),
                          TextButton(
                              onPressed: () {
                                currentMedal.when[i] =
                                    "2025-02-04 00:00:00.000";
                                whenModel.updateIndex(i, 2);
                              },
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    whenModel.selectedIndexes[i] == 2
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                              child: const Text("Puntual")),
                        ],
                      ),
                      if (whenModel.selectedIndexes[i] == 0)
                        Once()
                      else if (whenModel.selectedIndexes[i] == 1)
                        Periodically(i)
                      else if (whenModel.selectedIndexes[i] == 2)
                        Precisely(i),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              if (whenModel.selectedIndexes.length < 4)
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.lime),
                    ),
                    onPressed: () {
                      whenModel.addIndex();
                      currentMedal.when.add("");
                      currentMedal.how.add("");
                    },
                    child: Text('Añadir condición',
                        style: TextStyle(fontWeight: FontWeight.bold)))
            ],
          ))
        ],
      );
    });
  }

  // Analogous to when, with options "Retos", "Estadísticas" and "Medallas".
  Consumer<WhenModel> how() {
    return Consumer<WhenModel>(builder: (context, whenModel, child) {
      return Column(
        children: [
          Text('¿Cómo?',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              for (var i = 0; i < whenModel.selectedIndexes.length; i++)
                SizedBox(
                  height: 200,
                  width: 400,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                whenModel.updateChallengeIndex(i, 0);
                                currentMedal.how[i] =
                                    "ch/Cualquiera/Cualquiera/Cualquiera";
                              },
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    whenModel.challengeIndexes[i] == 0
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                              child: const Text("Retos")),
                          TextButton(
                              onPressed: () {
                                currentMedal.how[i] = "st/0/Cualquiera";
                                whenModel.updateChallengeIndex(i, 1);
                              },
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    whenModel.challengeIndexes[i] == 1
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                              child: const Text("Estadísticas")),
                          TextButton(
                              onPressed: () {
                                currentMedal.how[i] = "front/1";
                                whenModel.updateChallengeIndex(i, 2);
                              },
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    whenModel.challengeIndexes[i] == 2
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                              child: const Text("Plataforma")),
                          if (medalCollection.isNotEmpty)
                            TextButton(
                                onPressed: () {
                                  currentMedal.how[i] = "md/0";
                                  whenModel.updateChallengeIndex(i, 3);
                                },
                                style: ButtonStyle(
                                  foregroundColor: WidgetStateProperty.all(
                                      whenModel.challengeIndexes[i] == 3
                                          ? Colors.blue
                                          : Colors.black),
                                ),
                                child: const Text("Medallas")),
                        ],
                      ),
                      if (whenModel.challengeIndexes[i] == 0)
                        ChallengeCondition(i)
                      else if (whenModel.challengeIndexes[i] == 1)
                        StatsCondition(i)
                      else if (whenModel.challengeIndexes[i] == 2)
                        FrontCondition(i)
                      else if (whenModel.challengeIndexes[i] == 3)
                        MedalCondition(i),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
            ],
          )),
        ],
      );
    });
  }

  Column what() {
    return Column(
      children: [
        Text('¿Qué?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/img/medal.png', width: 200, height: 200),
              SizedBox(
                height: 50,
                width: 200,
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      currentMedal.name = text;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de la medalla',
                  ),
                ),
              ),
              Column(
                children: [
                  Text('Color de la medalla',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: currentMedal.color,
                    items:
                        <String>['Rojo', 'Verde', 'Azul'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {
                      setState(() {
                        currentMedal.color = _!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                  height: 200,
                  width: 200,
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        currentMedal.description = text;
                      });
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descripción de la medalla',
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
