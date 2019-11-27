import 'package:kobe_app/src/pages/movie/movie_api.dart';
import 'package:kobe_app/src/shared/simple_bloc.dart';

class MoviesBloc extends SimpleBloc {
  int page = 2;

  Future fetch({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        add(null);
      }

      final movies = await MoviesApi.getMovies();

      add(movies);

      return movies;
    } catch (error) {
      addError("Nenhum Filme !!!");
    }
  }
  Future fetchMore({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        add(null);
      }

      final movies = await MoviesApi.getMoviesMore(page);
      page ++;
      add(movies);

      return movies;
    } catch (error) {
      addError("Nenhum Filme !!!");
    }
  }
}