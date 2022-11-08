part of 'bloc.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character?> characters;

  CharacterLoaded({required this.characters});
}
