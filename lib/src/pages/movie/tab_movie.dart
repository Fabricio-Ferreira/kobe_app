import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:kobe_app/src/pages/movie/movie.dart';
import 'package:kobe_app/src/pages/movie/movie_page.dart';
import 'package:kobe_app/src/pages/movie/movies_bloc.dart';
import 'package:kobe_app/src/shared/nav.dart';
import 'package:kobe_app/src/shared/widgets/text_empty.dart';
import 'package:kobe_app/src/shared/widgets/text_error.dart';

class TabMovies extends StatefulWidget {
  @override
  _TabMoviesState createState() => _TabMoviesState();
}

class _TabMoviesState extends State<TabMovies>
    with AutomaticKeepAliveClientMixin<TabMovies> {
  @override
  bool get wantKeepAlive => true;

  final bloc = BlocProvider.getBloc<MoviesBloc>();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    bloc.fetch();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.fetchMore();
      }
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    List<Movie> list = [];

    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Erro
          return Center(
            child: TextError(
              snapshot.error,
              onRefresh: _onRefreshError,
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Movie> movies = snapshot.data;

        list.addAll(movies);

        return movies.isEmpty
            ? TextEmpty("Nenhum filme.")
            : _griView(context, list);
      },
    );
  }

  _griView(context, list) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _item(list, index, context);
        },
      ),
    );
  }

  _item(List<Movie> movies, index, context) {
    Movie m = movies[index];

    // Tag para a animação do Hero
    m.tag = m.title;

    return Material(
      child: InkWell(
        child: Hero(
          tag: m.tag,
          child: Image.network(
            m.urlFoto,
            fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          _onClickMovie(m);
        },
      ),
    );
  }

  void _onClickMovie(Movie m) {
    push(context, MoviePage(m));
  }

  Future<void> _onRefresh() {
    return bloc.fetch();
  }

  Future<void> _onRefreshError() {
    return bloc.fetch(isRefresh: true);
  }
}
