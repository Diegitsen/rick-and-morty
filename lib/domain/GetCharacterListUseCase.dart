import 'package:rick_and_morty/data/model/Character.dart';
import 'package:rick_and_morty/domain/BaseUseCase.dart';
import 'package:rick_and_morty/data/repository/RickAndMortyRepository.dart';

class GetCharacterListUseCase extends BaseUseCase<List<Character>> {
  RickAndMortyRepository rickAndMortyRepository;

  GetCharacterListUseCase(RickAndMortyRepository rickAndMortyRepository) {
    this.rickAndMortyRepository = rickAndMortyRepository;
  }

  @override
  Future<List<Character>> perform() {
    return rickAndMortyRepository.getCharacterList();
  }
}
