class Challenge {
  String name;
  String competence;

  Challenge(this.name, this.competence);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'competence': competence,
    };
  }
  // Example: String json = jsonEncode(medal.toJson());
}

List<Challenge> challengeCollection = <Challenge>[];
