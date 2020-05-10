import 'package:rick_and_morty/data/model/Character.dart';
import 'package:rick_and_morty/data/remote/RickAndMortyApi.dart';
import 'package:http/http.dart';
import 'dart:convert';

class RickAndMortyApiImpl implements RickAndMortyApi {
  
  @override
  Future<List<Character>> getCharacterList() async {
    try{
      final response = await get('https://rickandmortyapi.com/api/character/');
      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        var list = mapResponse['results'] as List;
        List<Character> listCharacter = List();
        for (var x=0;x<list.length;x++) {
          Character character = Character();
          character.name = list.asMap()[x]['name'];
          character.id = list.asMap()[x]['id'];
          character.status = list.asMap()[x]['status'];
          character.gender = list.asMap()[x]['gender'];
          character.species = list.asMap()[x]['species'];
          listCharacter.add(character);
        }
        return listCharacter;
      }else{
        throw Exception("Error Code: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("There was a problem with the connection");
    }
  }


}
