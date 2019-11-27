import 'package:kobe_app/src/pages/movie/movie.dart';
import 'package:kobe_app/src/pages/movie/movie_db.dart';
import 'package:kobe_app/src/shared/simple_bloc.dart';

class FavoritosBloc extends SimpleBloc<List<Movie>> {
  Future fetch({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        add(null);
      }

      final db = MovieDB.getInstance();
      final movies = await db.getMovies();

      add(movies);

      return movies;
    } catch (error, exception) {
      print("$error - $exception");

      addError("Nenhum filme nos favoritos.");
    }
  }
}
