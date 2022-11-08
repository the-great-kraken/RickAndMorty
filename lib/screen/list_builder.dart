import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:rickandmorty/widgets/character_card.dart';

import '../bloc/bloc.dart';

class ListBuilder extends StatefulWidget {
  const ListBuilder({Key? key}) : super(key: key);

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    CharacterBloc characterBloc = BlocProvider.of<CharacterBloc>(context);
    return BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
      if (state is CharacterLoaded) {
        return LazyLoadScrollView(
          onEndOfPage: () {
            characterBloc.add(LoadCharacter());
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: state.characters.length,
            itemBuilder: (context, index) {
              return characterCard(state.characters[index], context);
            },
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
