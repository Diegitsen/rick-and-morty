import 'package:rick_and_morty/data/model/Character.dart';
import 'package:rick_and_morty/data/remote/RickAndMortyApi.dart';
import 'package:rick_and_morty/data/repository/RickAndMortyRepository.dart';

class RickAndMortyRepositoryImpl implements RickAndMortyRepository{

  RickAndMortyApi rickAndMortyApi;

  RickAndMortyRepositoryImpl(RickAndMortyApi rickAndMortyApi){
    this.rickAndMortyApi = rickAndMortyApi;
  }

  @override
  Future<List<Character>> getCharacterList() {
    return rickAndMortyApi.getCharacterList();
  }
}