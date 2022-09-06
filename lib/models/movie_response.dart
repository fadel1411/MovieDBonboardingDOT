class Movie {     
  final String original_title;
  final String overview;
  final String poster_path; 
  final String release_date;
  

  const Movie({     
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.release_date, 
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(      
      original_title: json['original_title'],
      overview: json['overview'],
      poster_path: json['poster_path'], 
      release_date: json['release_date'],
    );
  }
}

