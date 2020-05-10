import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rick_and_morty/data/model/Character.dart';
import 'package:rick_and_morty/presentation/character_list/ViewModelCharacterList.dart';

class ViewCharacterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Personajes"),
        ),
        body: buildCharacterContent());
  }

  Widget buildCharacterContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTitleWidget(),
          CharacterListView(),
        ],
      ),
    );
  }

  Widget buildTitleWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text("Character List"),
      ),
    );
  }
}

class CharacterListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CharacterListViewState();
  }
}

class CharacterListViewState extends State<CharacterListView>
    with WidgetsBindingObserver {
  final ViewModelCharacterList viewModelCharacterList = ViewModelCharacterList();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        refresh();
      }
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    viewModelCharacterList.closeObservable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Character>>(
      stream: viewModelCharacterList.characterList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildCircularProgressIndicatorWidget();
        }
        if (snapshot.hasError) {
          showSnackBar(context, snapshot.error.toString());
          return buildListViewNoDataWidget();
        }
        if (snapshot.connectionState == ConnectionState.active) {
          var characterList = snapshot.data;
          if (null != characterList)
            return buildListViewWidget(characterList);
          else
            return buildListViewNoDataWidget();
        }
      },
    );
  }

  Widget buildListViewWidget(List<Character> characterList) {
    return Flexible(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: characterList.length,
          itemExtent: 25.0,
          itemBuilder: (BuildContext context, int index) {
            return Text(characterList[index].name);
          }),
    );
  }

  Widget buildListViewNoDataWidget() {
    return Expanded(
      child: Center(
        child: Text("No Data Available"),
      ),
    );
  }

  Widget buildCircularProgressIndicatorWidget() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void showSnackBar(BuildContext context, String errorMessage) async {
    await Future.delayed(Duration.zero);
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  void refresh() {
    viewModelCharacterList.getCharacterList();
    setState(() {});
  }
}
