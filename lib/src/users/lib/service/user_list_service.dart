import 'package:http/http.dart';
import 'dart:convert';

import 'package:tvShows/src/models/tvshow.dart';



class UserListService {
  final Client _http;
  UserListService(this._http);

  static final _headers = {'Content-Type': 'application/json'};
  static final String baseUrl = 'http://localhost:8000/users/';
  Future<List<TvShow>> showsList(String username) async {
    try {
      final response = await _http.get(baseUrl + "list/" + username);
      var clean = _extractData(response);
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
      return [TvShow.simple(0, '', '')];
    }
  }
    Future<List<String>> currentShowsList(String token) async {
    try {
      _headers.addAll({'Authorization': 'Token ' + token});
      final response = await _http.get(baseUrl + "list", headers: _headers);
      var clean = _extractData(response);
      List<String> shows = List();
        (clean as List).forEach(
          (show) {
            shows.add(show['original_name']);
          }
        );
      return shows;
    }catch (e) {
      return [];
    }
  }
  Future<bool> addToList(TvShow show, String token) async {
    try {
      _headers.addAll({'Authorization': 'Token ' + token});
      await _http.post(baseUrl + "add", body: json.encode(toJson(show)), headers: _headers);
    } catch (e) {
      return false;
    }
    return true;
  }

  Map<String, String> toJson(TvShow show) {
    var stringParams = <String, String>{};
    stringParams.addAll(
      {
        "id": show.id.toString(),
        "original_name": show.name,
        "backdrop_path": show.posterUrl.substring('http://image.tmdb.org/t/p/w185/'.length),
        "poster_path": show.posterUrl.substring('http://image.tmdb.org/t/p/w185/'.length),
        "vote_average": show.score.toString()
      }
    );
    return stringParams;
  }

  Future<void> makeSuggestion(String token, String user, TvShow show) async {
    try {
      _headers.addAll({'Authorization': 'Token ' + token});
      final response = await _http.post(baseUrl + "suggest", body: json.encode(toJsonWithUsername(show, user)), headers: _headers);
      print(_extractData(response));
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  Map<String, String> toJsonWithUsername(TvShow show, String username) {
    var stringParams = <String, String>{};
    stringParams.addAll(
      {
        "username": username,
        "id": show.id.toString(),
        "original_name": show.name,
        "backdrop_path": show.posterUrl.substring('http://image.tmdb.org/t/p/w185/'.length),
        "poster_path": show.posterUrl.substring('http://image.tmdb.org/t/p/w185/'.length),
        "vote_average": show.score.toString()
      }
    );
    return stringParams;
  }
  dynamic _extractData(Response resp) => json.decode(resp.body);
}
