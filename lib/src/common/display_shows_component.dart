import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:tvShows/src/models/tvshow.dart';
import 'package:tvShows/src/route_paths.dart';
import 'package:tvShows/src/users/lib/service/user_list_service.dart';


@Component(
  selector: 'display-shows',
  directives: [coreDirectives, routerDirectives, formDirectives],
  templateUrl: 'display_shows_component.html',
)

class DisplayShowsComponent implements OnInit {
  UserListService _service;
  String token = window.localStorage.containsKey('id') ? window.localStorage['id'] : '';
  List<TvShow> shows;
  List<String> userList;
  @Input()
  set listShows(List<TvShow> showsList) => shows = showsList;
  DisplayShowsComponent(this._service);
  bool added = false;
  String selected;

  String showUrl(String name) => RoutePaths.show_details.toUrl(parameters: {nameParam: '$name'});

  void addToList(TvShow show) async {
   added = await _service.addToList(show, token);
   selected = show.name;
  }

  @override
  void ngOnInit() async {
    userList = await _service.currentShowsList(token);
  }
}
