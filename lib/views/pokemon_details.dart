import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:poke_app/models/pokemon.dart';

import '../controllers/pokemon_controller.dart';

class PokemonDetails extends StatefulWidget {
  PokemonDetails({Key? key}) : super(key: key);

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  var pokeController = Get.put(PokemonController());
  var pokemon;
  @override
  void initState() {
    callApi();
    super.initState();
  }

  callApi() async {
    pokemon = await pokeController.getSinglePokemon(Get.arguments.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Pokemon>(
            future: pokeController.getSinglePokemon(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var pokemon = snapshot.data;
                return Center(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        colors: [
                          Color(0xff140373),
                          Color(0xff8F54E1),
                        ],
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SvgPicture.network(
                                pokemon!.image,
                                height: 250,
                                // fit: BoxFit.cover,
                                alignment: Alignment.center,
                                semanticsLabel: "Image of ${pokemon.name}",
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              pokemon.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Type",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Chip(
                                  label: Text(
                                    pokemon.type!.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: pokeController
                                      .getPokemonColor(pokemon.type),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            buildPokeStat("HP", pokemon.hp!),
                            buildPokeStat("Attack", pokemon.attack!),
                            buildPokeStat("Defense", pokemon.defense!),
                            buildPokeStat("Sp Attack", pokemon.spAttack!),
                            buildPokeStat("Sp Defense", pokemon.spDefense!),
                            buildPokeStat("Speed", pokemon.speed!),
                            if (context.isLandscape) SizedBox(height: 50)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  Padding buildPokeStat(String label, int stat) {
    return Padding(
      padding: context.isLandscape
          ? EdgeInsets.symmetric(horizontal: 150)
          : EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          Text(
            stat.toString(),
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
    );
  }
}
