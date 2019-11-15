class TvShow {
  int id;
  String name, language, overview, posterUrl;
  double score;
  int numberOfVotes, seasons;
  List<String> networks;
  List<Map<String, String>> episodesPerSeason;
  bool in_production;

  TvShow(this.id, this.name, this.language,
    this.overview, this.posterUrl,this.score, this.numberOfVotes);

  TvShow.details(this.id, this.name, this.language,
    this.overview, this.posterUrl,this.score, this.numberOfVotes, 
    this.seasons, this.episodesPerSeason, this.in_production, this.networks);
  
  TvShow.simple(this.id, this.name, this.posterUrl);

  factory TvShow.fromJson(Map<String, dynamic> show) =>
    new TvShow(show['id'], show['original_name'], show['original_language'],
      show['overview'], show.containsKey('poster_path') ? (show['poster_path'] == null ? '' : 'http://image.tmdb.org/t/p/w185/' + show['poster_path']) : '',
      show.containsKey('vote_average') ? show['vote_average'] : 0, show.containsKey('vote_count') ? show['vote_count']: 0);

  factory TvShow.searchFromJson(Map<String, dynamic> show) =>
    new TvShow.simple(show['id'], show['original_name'], 'http://image.tmdb.org/t/p/w185/' + show['backdrop_path']);

  factory TvShow.fromJsonDetails(Map<String, dynamic> show) =>
    new TvShow.details(show['id'], show['original_name'], show['original_language'], show['overview'],
     'http://image.tmdb.org/t/p/w185/' + show['poster_path'], show['vote_average'], show['vote_count'], 
      show['number_of_seasons'], getEpisodesPerSeason(show['seasons']), show['in_production'], 
      getNetworks(show['networks']));

  static List<Map<String, String>> getEpisodesPerSeason(dynamic seasons) {
    List<Map<String, String>> toReturn = List();
    for (Map<String, dynamic> season in seasons) {
      toReturn.add({'name': season['season_number'].toString(), 'episodes': season['episode_count'].toString()});
    }
    return toReturn;
  }

  static List<String> getNetworks(dynamic networks) {
    List<String> toReturn = List();
    for (Map<String, dynamic> network in networks) {
      toReturn.add( 'http://image.tmdb.org/t/p/w185' + network['logo_path']);
    }
    return toReturn;
  }
}
