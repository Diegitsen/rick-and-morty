import 'package:rick_and_morty/data/model/Character.dart';

abstract class RickAndMortyApi{
  Future<List<Character>> getCharacterList();
}