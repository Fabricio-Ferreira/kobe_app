import 'package:kobe_app/src/pages/movie/movie.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class MovieDB {
  static final MovieDB _instance = new MovieDB.getInstance();

  factory MovieDB() => _instance;

  MovieDB.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null && _db.isOpen) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'movies.db');
    print("db $path");

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE movie(id INTEGER PRIMARY KEY, title TEXT, poster_path TEXT, '
            'vote_average TEXT, overview TEXT, release_date TEXT, backdrop_path TEXT,'
            ' popularity TEXT, original_title TEXT, original_language TEXT, vote_count TEXT, video BOOL,'
            'adult BOOL)');
  }

  Future<int> saveMovie(Movie movie) async {
    var dbClient = await db;
    var id = await dbClient.insert("movie", movie.toJson());
    return id;
  }

  Future<List<Movie>> getMovies() async {
    final dbClient = await db;
    final mapMovies = await dbClient.rawQuery("select * from movie");
    final movies =
    mapMovies.map<Movie>((json) => Movie.fromJson(json)).toList();
    return movies;
  }

  Future<int> getCount() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from movie');
    return Sqflite.firstIntValue(result);
  }

  Future<Movie> getMovie(int id) async {
    var dbClient = await db;
    final result =
    await dbClient.rawQuery('select * from movie where id = ?', [id]);
    if (result.length > 0) {
      return new Movie.fromJson(result.first);
    }
    return null;
  }

  Future<bool> exists(Movie m) async {
    Movie c = await getMovie(m.id);
    var exists = c != null;
    return exists;
  }

  Future<int> deleteMovie(Movie m) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from movie where id = ?', [m.id]);
  }

  Future close() async {
    var dbClient = await db;
    await dbClient.close();
    dbClient = null;
  }
}