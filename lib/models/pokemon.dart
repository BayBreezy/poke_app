import 'dart:convert';

List<Pokemon> pokemonFromJson(String str) {
  return List<Pokemon>.from(json.decode(str).map((x) => Pokemon.fromJson(x)));
}

class Pokemon {
  final String name;
  final String? type;
  final String image;
  final int? hp;
  final int? attack;
  final int? defense;
  final int? spAttack;
  final int? spDefense;
  final int? speed;

  Pokemon(
      {required this.name,
      this.type,
      required this.image,
      this.hp,
      this.attack,
      this.defense,
      this.spAttack,
      this.spDefense,
      this.speed});

  factory Pokemon.fromJson(Map<dynamic, dynamic> json) {
    return Pokemon(
      name: json["name"],
      type: json.containsKey('types') ? json["types"][0]["type"]["name"] : '',
      image:
          "https://unpkg.com/pokeapi-sprites@2.0.2/sprites/pokemon/other/dream-world/${json["id"].toString()}.svg",
      hp: json.containsKey('stats') ? json["stats"][0]["base_stat"] : 0,
      attack: json.containsKey('stats') ? json["stats"][1]["base_stat"] : 0,
      defense: json.containsKey('stats') ? json["stats"][2]["base_stat"] : 0,
      spAttack: json.containsKey('stats') ? json["stats"][3]["base_stat"] : 0,
      spDefense: json.containsKey('stats') ? json["stats"][4]["base_stat"] : 0,
      speed: json.containsKey('stats') ? json["stats"][5]["base_stat"] : 0,
    );
  }
}
