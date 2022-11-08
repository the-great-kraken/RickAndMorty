import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickandmorty/bloc/bloc.dart';

import 'package:rickandmorty/model/character.dart';
import 'package:rickandmorty/screen/list_builder.dart';
import 'package:rickandmorty/screen/list_screen.dart';

class MockPostBloc extends MockBloc<CharacterEvent, CharacterState>
    implements CharacterBloc {}

extension on WidgetTester {
  Future<void> pumpPostsList(CharacterBloc characterBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: characterBloc,
          child: const ListBuilder(),
        ),
      ),
    );
  }
}

void main() {
  late CharacterBloc characterBloc;

  setUp(() {
    characterBloc = MockPostBloc();
  });
  group('ListScreen', () {
    testWidgets('Renders list', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ListScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(ListBuilder), findsOneWidget);
    });

    testWidgets('Fetches more posts when scrolled to the bottom',
        (tester) async {
      await tester.pumpPostsList(characterBloc);
      await tester.drag(find.byType(ListBuilder), const Offset(0, -500));
      verifyNever(() => characterBloc.add(LoadCharacter())).called(1);
    });
  });

  group('Character', () {
    test("Parses Characters from the API", () {
      // https://rickandmortyapi.com/api/character/1
      const characterJson = {
        "id": 1,
        "name": "Rick Sanchez",
        "status": "Alive",
        "species": "Human",
        "type": "",
        "gender": "Male",
        "origin": {
          "name": "Earth (C-137)",
          "url": "https://rickandmortyapi.com/api/location/1"
        },
        "location": {
          "name": "Earth (Replacement Dimension)",
          "url": "https://rickandmortyapi.com/api/location/20"
        },
        "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        "episode": [
          "https://rickandmortyapi.com/api/episode/1",
          "https://rickandmortyapi.com/api/episode/2",
          "https://rickandmortyapi.com/api/episode/3",
        ],
        "url": "https://rickandmortyapi.com/api/character/1",
        "created": "2017-11-04T18:48:46.250Z"
      };

      Character character = Character.fromJson(characterJson);

      expect(character.id, 1);
      expect(character.name, "Rick Sanchez");
    });
  });
}
