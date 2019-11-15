import 'package:http/http.dart';
import 'dart:convert';

import 'package:tvShows/src/models/tvshow.dart';



class TvShowsService {
  final Client _http;
  TvShowsService(this._http);

  static final String baseUrlSearch = 'https://api.themoviedb.org/3/search/tv?api_key=f9f42fcf33957ec843de3e737dcdf3a0&language=en-US&query=';
  Future<List<TvShow>> searchShow(String title) async {
    try {
      final response = await _http.get(baseUrlSearch + title);
      var clean = _extractData(response)['results'];
    List<TvShow> shows = List();
      (clean as List).forEach(
        (show) {
          if(show.containsKey('poster_path') && show['poster_path'] != null) {
             shows.add(TvShow.fromJson(show));
          }
        }
      );
      return shows;
    }catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<TvShow> getShowDetails({String title, int id}) async {
    try {
      if(title.isNotEmpty){
        final response = await _http.get(baseUrlSearch + title);
        final response2 = await _http.get('https://api.themoviedb.org/3/tv/'+ _extractData(response)['results'][0]['id'].toString() +'?api_key=f9f42fcf33957ec843de3e737dcdf3a0&language=en-US');
        return TvShow.fromJsonDetails(_extractData(response2));      
      } else {
        final response = await _http.get('https://api.themoviedb.org/3/tv/'+ id.toString() +'?api_key=f9f42fcf33957ec843de3e737dcdf3a0&language=en-US');
        return TvShow.fromJsonDetails(_extractData(response));
      }
    }catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<TvShow>> getPopularShows(int page) async {
    try {
      final response = await _http.get('https://api.themoviedb.org/3/tv/popular?api_key=f9f42fcf33957ec843de3e737dcdf3a0&language=en-US&page='+ page.toString());
      var clean = _extractData(response)['results'];
      final shows = (clean as List)
        .map((value) => TvShow.fromJson(value))
        .toList();
      return shows;
    } catch(e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<TvShow>> search(String title) async {
    try {
      final response = await _http.get(baseUrlSearch + title);
      var clean = _extractData(response)['results'];
      List<TvShow> shows = List();
      (clean as List).forEach(
        (show) {
          if(show.containsKey('backdrop_path') && show['backdrop_path'] != null) {
             shows.add(TvShow.searchFromJson(show));
          }
        }
      );
      return shows;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  dynamic _extractData(Response resp) => json.decode(resp.body);
}
