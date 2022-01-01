import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:poke_app/views/pokemon_details.dart';

import '../../controllers/pokemon_controller.dart';
import '../../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    Key? key,
    required this.pokeController,
    required this.pokemon,
    required this.i,
  }) : super(key: key);

  final PokemonController pokeController;
  final Pokemon pokemon;
  final int i;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PokemonDetails(), arguments: pokemon.name);
      },
      child: Container(
        height: i % 2 == 0 ? 250 : 230,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Center(
            child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Hero(
                  tag: pokemon.name,
                  child: SvgPicture.network(
                    pokemon.image,
                    height: i % 2 == 0 ? 250 : 230,
                    // fit: BoxFit.cover,
                    alignment: Alignment.center,
                    semanticsLabel: "Image of ${pokemon.name}",
                    placeholderBuilder: (BuildContext context) =>
                        Container(child: const CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
            Text(
              pokemon.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        )),
      ),
    );
  }
}
