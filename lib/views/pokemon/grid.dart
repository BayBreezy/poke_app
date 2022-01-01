import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../controllers/pokemon_controller.dart';
import 'card.dart';

class PokemonGrid extends StatelessWidget {
  const PokemonGrid({
    Key? key,
    required this.pokeController,
  }) : super(key: key);

  final PokemonController pokeController;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      gridDelegate: const SliverMasonryGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: pokeController.pokemonList.length,
      itemBuilder: (ctx, i) {
        var pokemon = pokeController.pokemonList[i];
        return PokemonCard(
          pokeController: pokeController,
          pokemon: pokemon,
          i: i,
        );
      },
    );
  }
}
