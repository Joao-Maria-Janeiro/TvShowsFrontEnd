import 'package:http/http.dart';
import 'dart:convert';



class SeasonService {
  final Client _http;
  SeasonService(this._http);

  Future<List<String>> getSeasonEpisodes(int id, int season) async {
    try {
      final response = await _http.get('https://api.themoviedb.org/3/tv/' + id.toString() + '/season/' + season.toString() + '?api_key=f9f42fcf33957ec843de3e737dcdf3a0&language=en-US');
      var clean = _extractData(response);
      List<String> episodes = List();
      for (Map<String, dynamic> episode in clean['episodes'] as List) {
        episodes.add(episode['name']);
      }
      return episodes;
    }catch (e) {
      return null;
    }
  }
  dynamic _extractData(Response resp) => json.decode(resp.body);
}
