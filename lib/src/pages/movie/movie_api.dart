import 'package:kobe_app/src/pages/movie/movie.dart';
import 'package:kobe_app/src/shared/constaints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MoviesApi {
  static bool fake = false;


  static Future<List<Movie>> getMovies() async {
    final url =
        "https://api.themoviedb.org/3/movie/popular?api_key=$api_key&language=pt-BR";

    final response = await http.get(url);
    var jsonData = (convert.json.decode(response.body)["results"]);
    List<Movie> movies =
        jsonData.map<Movie>((json) => Movie.fromJson(json)).toList();

    return movies;
  }
  static Future<List<Movie>> getMoviesMore(int page) async {

    final url =
        "https://api.themoviedb.org/3/movie/popular?api_key=$api_key&language=pt-BR&page=$page";
    final response = await http.get(url);
    var jsonData = (convert.json.decode(response.body)["results"]);
    List<Movie> movies =
    jsonData.map<Movie>((json) => Movie.fromJson(json)).toList();


    return movies;
  }
}
