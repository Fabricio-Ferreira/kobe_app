import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:kobe_app/src/pages/favorites/favorite_bloc.dart';
import 'package:kobe_app/src/pages/movie/movie.dart';
import 'package:kobe_app/src/pages/movie/movie_db.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  // Flag do favorito
  final _flagFavoritos = BehaviorSubject<bool>();
  get getFavoritos => _flagFavoritos.stream;
  get setFavorito => _flagFavoritos.sink.add;

  Future<bool> fetchFavorito(Movie m) async {
    final db = MovieDB.getInstance();

    final b = await db.exists(m);

    setFavorito(b);

    return b;
  }

  Future<bool> favoritar(Movie m) async {
    final db = MovieDB.getInstance();

    final exists = await db.exists(m);

    try {
      if (exists) {
        await db.deleteMovie(m);

        setFavorito(false);

        return false;
      } else {
        await db.saveMovie(m);

        setFavorito(true);

        return true;
      }
    } finally {
      // Atualiza o bloc de favoritos
      final favoritosBloc = BlocProvider.getBloc<FavoritosBloc>();
      favoritosBloc.fetch();
    }
  }

  dispose() {
    _flagFavoritos.close();
  }
}