import 'package:flutter/material.dart';
import '/models/medals.dart';

class Once extends StatelessWidget {
  const Once({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Cuando se cumpla la condición");
  }
}

class Periodically extends StatefulWidget {
  Periodically(this.position, {super.key});
  int position;

  @override
  State<Periodically> createState() => _PeriodicallyState();
}

class _PeriodicallyState extends State<Periodically> {
  String _length = "";
  String _interval = "días";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Si cumple la condición durante "),
        const SizedBox(width: 5),
        SizedBox(
            width: 40,
            height: 60,
            child: TextField(
                maxLength: 3,
                onChanged: (value) {
                  _length = value;
                  currentMedal.when[widget.position] = "$_length/$_interval";
                })),
        const SizedBox(width: 5),
        DropdownButton<String>(
            value: _interval,
            items: <String>['días', 'semanas', 'meses'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {
              _interval = _!;
              currentMedal.when[widget.position] = "$_length/$_interval";
              setState(() {});
            })
      ],
    );
  }
}

class Precisely extends StatefulWidget {
  Precisely(this.position, {super.key});

  int position;
  DateTime date = DateTime.now();

  @override
  State<Precisely> createState() => _PreciselyState();
}

class _PreciselyState extends State<Precisely> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text("Cumplir la condición el día "),
      TextButton(
        child:
            Text("${widget.date.day}/${widget.date.month}/${widget.date.year}"),
        onPressed: () {
          showDatePicker(
                  context: context,
                  initialDate: widget.date,
                  firstDate: widget.date,
                  lastDate: DateTime(2026))
              .then((date) {
            widget.date = date!;
            currentMedal.when[widget.position] = "${widget.date}";
            setState(() {});
          });
        },
      ),
    ]);
  }
}
