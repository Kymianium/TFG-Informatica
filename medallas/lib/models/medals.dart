class Medal {
  String name;
  String color;
  String description;
  var when = <String>[];
  var how = <String>[];
  var winners = <String>[];

  Medal(this.name, this.color, this.description, this.when, this.how);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color,
      'description': description,
      'when': when,
      'how': how,
      'winners': winners,
    };
  }
  // Example: String json = jsonEncode(medal.toJson());
}

var medalCollection = <Medal>[];
Medal currentMedal = Medal("", "Rojo", "", [""], [""]);
