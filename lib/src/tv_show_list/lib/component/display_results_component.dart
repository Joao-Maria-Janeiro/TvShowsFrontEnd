import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:tvShows/src/common/display_shows_component.dart';
import 'package:tvShows/src/models/tvshow.dart';
import 'package:tvShows/src/route_paths.dart';
import 'package:tvShows/src/tv_show_list/lib/service/tv_show_service.dart';

@Component (
  selector: 'display-results',
  directives: [coreDirectives,formDirectives, routerDirectives, DisplayShowsComponent],
  templateUrl: 'display_results_component.html',
)
class DisplayResultsComponent implements OnActivate{
  List<TvShow> shows;
  final TvShowsService _service;
  DisplayResultsComponent(this._service);

  @Input()
  set values(String received) {
    getResults(received);
  }

  String showUrl(String name) => RoutePaths.show_details.toUrl(parameters: {nameParam: '$name'});

  Future<void> getResults(String name) async {
    try {
      shows = await _service.searchShow(name);
    } catch(e) {
      //no-op
    }
  }

  @override
  void onActivate(_, RouterState current) async {
    final showName = getName(current.parameters);
    if (showName != null) shows = await _service.searchShow(showName);
  }
}
