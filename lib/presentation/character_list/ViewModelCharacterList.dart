import 'package:rxdart/rxdart.dart';
import 'package:rick_and_morty/data/model/Character.dart';
import 'package:rick_and_morty/data/remote/RickAndMortyApiImpl.dart';
import 'package:rick_and_morty/domain/GetCharacterListUseCase.dart';
import 'package:rick_and_morty/data/repository/RickAndMortyRepositoryImpl.dart';

class ViewModelCharacterList {
  var characterListSubject = PublishSubject<List<Character>>();

  Observable<List<Character>> get characterList => characterListSubject.stream;
  GetCharacterListUseCase getCharacterListUseCase =
      GetCharacterListUseCase(RickAndMortyRepositoryImpl(RickAndMortyApiImpl()));

  void getCharacterList() async {
    try {
      characterListSubject = PublishSubject<List<Character>>();
      characterListSubject.sink.add(await getCharacterListUseCase.perform());
    } catch (e) {
      await Future.delayed(Duration(milliseconds: 500));
      characterListSubject.sink.addError(e);
    }
  }

  void closeObservable() {
    characterListSubject.close();
  }
}
