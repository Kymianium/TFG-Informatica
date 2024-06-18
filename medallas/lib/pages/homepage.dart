import 'package:flutter/material.dart';
import '/widgets/homepage_button.dart';
import '/network/manager.dart';
import '/models/medals.dart';
import '/models/challenges.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[350],
        title: const Text("Gestor de Medallas"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 250,
              child: HomepageButton(
                image: 'assets/img/add.png',
                text: 'Añadir medalla',
                route: '/define_medal',
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const SizedBox(
              height: 250,
              child: HomepageButton(
                image: 'assets/img/medals.png',
                text: 'Consultar medallas',
                route: '/consult_medals',
              ),
            ),
            StreamBuilder(
              stream: Manager().channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _processInput(context, snapshot.data);
                  });
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _processInput(BuildContext context, String message) {
  String answer = "";
  List<String> messageData = message.split("/");
  if (messageData[0] == "md") {
    answer =
        "El alumno ${messageData[1]} ha recibido la medalla ${messageData[2]}";
    for (var medal in medalCollection) {
      if (medal.name == messageData[2]) {
        medal.winners.add(messageData[1]);
        break;
      }
    }
  } else if (messageData[0] == "reto") {
    answer = "El reto ${messageData[1]} ha sido creado";
    challengeCollection.add(Challenge(messageData[1], messageData[2]));
  } else {
    answer = "Mensaje recibido: $message";
  }

  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          const Icon(Icons.info),
          const SizedBox(width: 20),
          Text(answer),
        ],
      ),
    ),
  );
}
