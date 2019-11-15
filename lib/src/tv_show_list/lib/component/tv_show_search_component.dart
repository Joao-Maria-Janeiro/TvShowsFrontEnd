import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:tvShows/src/models/tvshow.dart';
import 'package:tvShows/src/route_paths.dart';
import 'package:tvShows/src/tv_shows_details/lib/component/tv_show_component.dart';
import 'package:tvShows/src/tv_show_list/lib/service/tv_show_service.dart';

@Component(
  selector: 'show-search',
  templateUrl: 'tv_show_search_component.html',
  directives: [coreDirectives, formDirectives, routerDirectives, TvShowComponent],
  providers: [ClassProvider(TvShowsService)],
  pipes: [commonPipes],
)

class ShowSearchComponent implements OnInit {
  TvShowsService _tvShowService;
  Router _router;
  Stream<List<TvShow>> shows;
  StreamController<String> _searchTerms = StreamController<String>.broadcast();
  List<TvShow> results = List();
  ShowSearchComponent(this._tvShowService, this._router) {}

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
  String showUrl(String name) => RoutePaths.show_details.toUrl(parameters: {nameParam: '$name'});
  String resultsUrl(String name) => RoutePaths.display_results.toUrl(parameters: {nameParam: '$name'});

  Future<NavigationResult> gotoDetail(TvShow show) {
    InputElement input = querySelector("#search-box");
    var uri = _router.navigate(showUrl(show.name));
    input.value = " ";
    search("");
    return uri;
  }

    Future<NavigationResult> gotoResult(String show) {
    InputElement input = querySelector("#search-box");
    var uri = _router.navigate(resultsUrl(show));
    input.value = " ";
    search("");
    return uri;
  }

}
