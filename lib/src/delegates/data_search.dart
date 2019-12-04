import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kobe_app/src/shared/constaints.dart';

class DataSearch extends SearchDelegate<String> {
  int idMovie;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, idMovie.toString()));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List>(
          future: suggestions(query),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index]),
                    leading: Icon(Icons.play_arrow),
                    onTap: () {
                      close(context, snapshot.data[index]);
                    },
                  );
                },
                itemCount: snapshot.data.length,
              );
            }
          });
    }
  }

  Future<List> suggestions(String search) async {
    http.Response response = await http.get(
        "https://api.themoviedb.org/3/search/movie?api_key=$api_key&language=pt-BR&query=$search&page=1");

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)["results"];
      return jsonData.map((v) {
        idMovie = (v["id"]);
        print(idMovie);
        return v["title"];
      }).toList();
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}
