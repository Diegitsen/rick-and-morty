import 'package:rick_and_morty/data/model/Character.dart';

abstract class RickAndMortyRepository{
  Future<List<Character>> getCharacterList();
}