import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/character_list/ViewCharacterList.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Characters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ViewCharacterList()
    );
  }
}
