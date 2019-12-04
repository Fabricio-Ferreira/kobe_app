import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kobe_app/src/delegates/data_search.dart';
import 'package:kobe_app/src/pages/favorites/favorite_bloc.dart';
import 'package:kobe_app/src/pages/favorites/tab_favorite.dart';
import 'package:kobe_app/src/pages/home/drawner.dart';
import 'package:kobe_app/src/pages/movie/movie_page.dart';
import 'package:kobe_app/src/pages/movie/movies_bloc.dart';
import 'package:kobe_app/src/pages/movie/tab_movie.dart';
import 'package:kobe_app/src/shared/nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => MoviesBloc()),
        Bloc((i) => FavoritosBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Kobe Filmes App"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result = await showSearch(context: context, delegate: DataSearch());
                print(result);
                //push(context, MoviePage(result));
              },
            )
          ],
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: "Filmes",
                icon: Icon(Icons.movie),
              ),
              Tab(
                text: "Favoritos",
                icon: Icon(Icons.favorite),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            TabMovies(),
            TabFavoritos(),
          ],
        ),
        drawer: DrawerMenu(),
      ),
    );
  }
}