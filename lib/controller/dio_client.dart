import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rickandmorty/model/character.dart';

class DioClient {
  final Dio _dio = Dio();

  Future<List<Character?>> getCharacters() async {
    List<dynamic> character = [];
    try {
      final ids = List.generate(4, (index) => _getId());
      final url = 'https://rickandmortyapi.com/api/character/$ids';

      Response characterData = await _dio.get(url);

      character = characterData.data.map((e) => Character.fromJson(e)).toList();
    } on DioError catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error! Status: ${e.response?.statusCode}');
        }
      } else {
        if (kDebugMode) {
          print('Error sending request! ${e.message}');
        }
      }
    }

    return character.map((e) => e as Character).toList();
  }

  _getId() {
    return Random().nextInt(826) + 1;
  }
}
