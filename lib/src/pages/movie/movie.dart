class Movie {
  double popularity;
  int vote_count;
  bool video;
  String poster_path;
  int id;
  bool adult;
  String backdrop_path;
  String original_language;
  String original_title;
  String title;
  double vote_average;
  String overview;
  String release_date;

  // Tag para controlar o Hero
  String tag;

  get urlFoto => "https://image.tmdb.org/t/p/w300" + poster_path;

  Movie(
      {this.popularity,
      this.vote_count,
      this.video,
      this.poster_path,
      this.id,
      this.adult,
      this.backdrop_path,
      this.original_language,
      this.original_title,
      this.title,
      this.vote_average,
      this.overview,
      this.release_date});

  Movie.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'];
    vote_count = json['vote_count'];
    video = json['video'];
    poster_path = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdrop_path = json['backdrop_path'];
    original_language = json['original_language'];
    original_title = json['original_title'];
    title = json['title'];
    vote_average = json["vote_average"] == null
        ? 0
        : double.parse(json["vote_average"].toString());
    overview = json['overview'];
    release_date = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['vote_count'] = this.vote_count;
    data['video'] = this.video;
    data['poster_path'] = this.poster_path;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdrop_path;
    data['original_language'] = this.original_language;
    data['original_title'] = this.original_title;
    data['title'] = this.title;
    data['vote_average'] = this.vote_average;
    data['overview'] = this.overview;
    data['release_date'] = this.release_date;
    return data;
  }

  @override
  String toString() {
    return title;
  }
}
