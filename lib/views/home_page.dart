import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:poke_app/controllers/pokemon_controller.dart';

import 'pokemon/grid.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var pokeController = Get.put(PokemonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8F54E1),
          elevation: 2,
          toolbarHeight: 80,
          title: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Image.asset(
              "assets/pk.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        body: Obx(
          () => pokeController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Center(
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
                      child: PokemonGrid(pokeController: pokeController),
                    ),
                  ),
                ),
        ));
  }
}
