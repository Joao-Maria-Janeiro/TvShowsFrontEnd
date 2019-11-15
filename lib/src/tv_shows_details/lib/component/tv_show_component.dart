import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:tvShows/src/models/tvshow.dart';
import 'package:tvShows/src/route_paths.dart';
import 'package:tvShows/src/tv_show_list/lib/service/tv_show_service.dart';
import 'package:tvShows/src/tv_shows_details/services/season_service.dart';
import 'package:tvShows/src/users/lib/service/user_list_service.dart';

@Component (
  selector: 'search-show',
  directives: [coreDirectives,formDirectives, routerDirectives],
  templateUrl: 'tv_show_component.html',
)
class TvShowComponent implements OnActivate {
  TvShow show;
  String selected;
  final TvShowsService _service;
  final SeasonService _seasonService;
  final UserListService _userService;
  TvShowComponent(this._service, this._seasonService, this._userService);
  List<String> season;
  List<String> userList;
  String token = window.localStorage.containsKey('id') ? window.localStorage['id'] : '';
  bool added = false;

  @Input()
  set value(TvShow received) {
    getDetails(received);
  }

  void getSeason(String seasonName) async {
    selected=seasonName;
    int seasonNumber = int.parse(seasonName);
    season = await _seasonService.getSeasonEpisodes(show.id, seasonNumber);
  }

  Future<void> getDetails(TvShow received) async {
    show = await _service.getShowDetails(id: received.id);
  }

  void addToList(TvShow show) async {
   added = await _userService.addToList(show, token);
   added = true;
  }

  @override
  void onActivate(_, RouterState current) async {
    final showName = getName(current.parameters);
    if (showName != null) show = await _service.getShowDetails(title: showName);
    userList = await _userService.currentShowsList(token);
  }
}
