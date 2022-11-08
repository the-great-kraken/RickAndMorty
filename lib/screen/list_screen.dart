import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import 'list_builder.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Rick and Morty',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(32, 35, 41, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
      ),
      backgroundColor: const Color.fromRGBO(32, 35, 41, 1),
      body: BlocProvider<CharacterBloc>(
        create: (context) => CharacterBloc()..add(LoadCharacter()),
        child: const ListBuilder(),
      ),
    );
  }
}
