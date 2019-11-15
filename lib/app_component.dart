import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:tvShows/src/route_paths.dart';
import 'package:tvShows/src/routes.dart';
import 'package:tvShows/src/tv_show_list/lib/component/popular_shows_component.dart';
import 'package:tvShows/src/tv_shows_details/lib/component/tv_show_component.dart';
import 'package:tvShows/src/tv_show_list/lib/component/tv_show_search_component.dart';
import 'package:tvShows/src/tv_show_list/lib/service/tv_show_service.dart';
import 'package:tvShows/src/tv_shows_details/services/season_service.dart';
import 'package:tvShows/src/users/lib/component/login_component.dart';
import 'package:tvShows/src/users/lib/service/login_service.dart';
import 'package:tvShows/src/users/lib/service/user_list_service.dart';

@Component(
  selector: 'app-component',
  providers: [ClassProvider(TvShowsService), ClassProvider(LoginService), ClassProvider(UserListService), ClassProvider(SeasonService)],
  exports: [RoutePaths, Routes],
  directives: [coreDirectives,routerDirectives, formDirectives, TvShowComponent, PopularShowsComponent, ShowSearchComponent, LoginComponent],
  templateUrl: 'app_component.html',
)
class AppComponent {
  final title = 'Hello';
  String name;
  String token = window.localStorage.containsKey('name') ? window.localStorage['name'] : '';

  String userListUrl(String name) => RoutePaths.user_list.toUrl(parameters: {nameParam: '$name'});

}
