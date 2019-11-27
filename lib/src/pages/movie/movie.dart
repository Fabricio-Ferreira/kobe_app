class Movie {
  int id;
  String title;
  String poster_path;
  double vote_average;
  String overview;
  String release_date;
  String backdrop_path;
  double popularity;
  String original_title;
  String original_language;
  int vote_count;
  bool video;
  bool adult;

  // Tag para controlar o Hero
  String tag;

  get urlFoto => "https://image.tmdb.org/t/p/w300" + poster_path;

  Movie(
      {this.id,
      this.title,
      this.poster_path,
      this.vote_average,
      this.overview,
      this.release_date,
      this.backdrop_path,
      this.popularity,
      this.original_title,
      this.original_language,
      this.vote_count,
      this.video,
      this.adult});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    poster_path = json['poster_path'];
    vote_average = json["vote_average"] == null
        ? 0
        : double.parse(json["vote_average"].toString());
    overview = json['overview'];
    release_date = json['release_date'];
    backdrop_path = json['backdrop_path'];
    popularity = json['popularity'];
    original_title = json['original_title'];
    original_language = json['original_language'];
    vote_count = json['vote_count'];
    video = json['video'];
    adult = json['adult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['poster_path'] = this.poster_path;
    data['vote_average'] = this.vote_average;
    data['overview'] = this.overview;
    data['release_date'] = this.release_date;
    data['backdrop_path'] = this.backdrop_path;
    data['popularity'] = this.popularity;
    data['original_title'] = this.original_title;
    data['original_language'] = this.original_language;
    data['vote_count'] = this.vote_count;
    data['video'] = this.video;
    data['adult'] = this.adult;
    
    return data;
  }

  @override
  String toString() {
    return title;
  }
}
