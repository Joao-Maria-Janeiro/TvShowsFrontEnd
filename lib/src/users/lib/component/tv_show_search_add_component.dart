import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:tvShows/src/models/tvshow.dart';
import 'package:tvShows/src/tv_shows_details/lib/component/tv_show_component.dart';
import 'package:tvShows/src/tv_show_list/lib/service/tv_show_service.dart';
import 'package:tvShows/src/users/lib/service/user_list_service.dart';

@Component(
  selector: 'show-search-add',
  templateUrl: 'tv_show_search_add_component.html',
  directives: [coreDirectives, formDirectives, routerDirectives, TvShowComponent],
  providers: [ClassProvider(TvShowsService)],
  pipes: [commonPipes],
)

class ShowSearchAddComponent implements OnInit {
  TvShowsService _tvShowService;
  UserListService _userListService;
  Stream<List<TvShow>> shows;
  StreamController<String> _searchTerms = StreamController<String>.broadcast();
  List<TvShow> results = List();
  ShowSearchAddComponent(this._tvShowService, this._userListService); 
  @Input() String username;

  void search(String term) => _searchTerms.add(term);
  void ngOnInit() async {
    shows = _searchTerms.stream
        .transform(debounce(Duration(milliseconds: 100)))
        .distinct()
        .transform(switchMap((term) => term.isEmpty
            ? Stream<List<TvShow>>.fromIterable([<TvShow>[]])
            : _tvShowService.search(term).asStream()))
        .handleError((e) {
    });
  }

  void makeSuggestion(TvShow show) async {
    InputElement input = querySelector("#search-box");
    await _userListService.makeSuggestion(window.localStorage['name'], username, show);
    input.value = " ";
    search("");
    return;
  }
}
