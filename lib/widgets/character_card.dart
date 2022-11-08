import 'package:flutter/material.dart';

import '../model/character.dart';

Widget characterCard(Character? character, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: SizedBox(
      width: 350,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: Image.network(
            '${character!.image}',
            scale: 0.86,
          ),
        ),
        SizedBox(
          width: 350,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name ?? '',
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: character.status == 'Alive'
                            ? Colors.green
                            : Colors.red,
                        size: 12,
                      ),
                      Text(
                        ' ${character.status} - ${character.species}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '\nLast known location:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                    ),
                  ),
                  Text(
                    character.location ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    '\nFirst seen in:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                    ),
                  ),
                  Text(
                    character.origin ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            color: const Color.fromRGBO(60, 62, 68, 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            margin: const EdgeInsets.only(top: 0),
          ),
        ),
      ]),
    ),
  );
}
