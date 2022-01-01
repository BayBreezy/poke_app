import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_app/api_client.dart';
import 'package:poke_app/models/pokemon.dart';

class PokemonController extends GetxController {
  var isLoading = true.obs;
  List<Pokemon> pokemonList = <Pokemon>[].obs;

  ///Method used to get all pokemons from 1-151
  Future<void> getFirst150Pokemon() async {
    try {
      isLoading.value = true;
      var res = await ApiClient.client
          .get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=151"));

      if (res.statusCode == 200) {
        var j = jsonDecode(res.body)["results"];
        var pks = <Map<String, dynamic>>[];
        for (var i = 0; i < j.length; i++) {
          var pokemon = j[i];
          pokemon["id"] = "${i + 1}";
          pks.add(pokemon);
        }
        var encoded = jsonEncode(pks);
        pokemonList = pokemonFromJson(encoded);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        e.toString(),
        borderRadius: 5.0,
      );
    } finally {
      isLoading.value = false;
    }
  }

  ///Get teh color for the type passed in
  Color getPokemonColor(String? type) {
    switch (type) {
      case "grass":
        return Colors.green;
        break;
      case "fire":
        return Colors.red;
        break;
      case "water":
        return Colors.blue;
        break;
      case "poison":
        return Colors.purple;
        break;
      case "psychic":
        return Colors.purple;
        break;
      case "normal":
        return Colors.brown;
        break;
      case "ground":
        return Color.fromARGB(225, 100, 66, 54);
        break;
      case "bug":
        return Color.fromARGB(255, 1, 88, 20);
        break;
      case "rock":
        return Color.fromARGB(255, 116, 116, 116);
        break;
      case "steel":
        return Color.fromARGB(255, 116, 116, 116);
        break;
      case "electric":
        return Color.fromARGB(255, 229, 233, 0);
        break;
      case "fairy":
        return Color.fromARGB(255, 203, 0, 221);
        break;
      case "ghost":
        return Color.fromARGB(255, 52, 0, 136);
        break;
      case "dragon":
        return Color.fromARGB(255, 52, 0, 136);
        break;
      default:
        return Colors.grey;
    }
  }

  ///API called used to get a single pokemon
  Future<Pokemon> getSinglePokemon(String name) async {
    try {
      var res = await ApiClient.client
          .get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$name"));

      if (res.statusCode == 200) {
        var j = json.decode(res.body);
        return Pokemon.fromJson(j);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        borderRadius: 5.0,
      );
    }
    throw "Pokemon could not be found";
  }

  @override
  void onInit() {
    getFirst150Pokemon();
    super.onInit();
  }
}
