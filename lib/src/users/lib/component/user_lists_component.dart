import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:tvShows/src/common/display_shows_component.dart';
import 'package:tvShows/src/models/tvshow.dart';
import 'package:tvShows/src/route_paths.dart';
import 'package:tvShows/src/users/lib/component/tv_show_search_add_component.dart';
import 'package:tvShows/src/users/lib/service/user_list_service.dart';

@Component (
  selector: 'display-results',
  directives: [coreDirectives,formDirectives, routerDirectives, DisplayShowsComponent, ShowSearchAddComponent],
  templateUrl: 'user_lists_component.html',
)
class UserListComponent implements OnActivate{
  List<TvShow> shows;
  final UserListService _service;
  String username, user;
  bool loggedIn = window.localStorage.containsKey('id');
  UserListComponent(this._service);

  @override
  void onActivate(_, RouterState current) async {
    username = getName(current.parameters);
    if (username != null) shows = await _service.showsList(username);
    window.localStorage.containsKey('name') ? user = window.localStorage['name'] : '';
  }
}
