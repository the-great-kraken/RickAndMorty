import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:rickandmorty/model/character.dart';
import 'package:rickandmorty/controller/dio_client.dart';

part 'event.dart';
part 'state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final List<Character?> _characters = [];

  CharacterBloc() : super(CharacterInitial()) {
    on<LoadCharacter>(_onLoad);
  }

  void _onLoad(CharacterEvent event, Emitter<CharacterState> emit) async {
    final newCharacters = await DioClient().getCharacters();
    _characters.addAll(newCharacters);
    emit(CharacterLoaded(characters: _characters));
  }
}
