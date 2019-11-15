import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:tvShows/src/common/display_shows_component.dart';
import 'package:tvShows/src/models/tvshow.dart';
import 'package:tvShows/src/tv_shows_details/lib/component/tv_show_component.dart';
import 'package:tvShows/src/tv_show_list/lib/service/tv_show_service.dart';

import '../../../route_paths.dart';

@Component(
  selector: 'popular-shows',
  directives: [coreDirectives, formDirectives, routerDirectives, TvShowComponent, DisplayShowsComponent],
  templateUrl: 'popular_shows_component.html',
  styleUrls: ['style.css'],
)

class PopularShowsComponent implements OnInit {
  List<TvShow> shows;
  TvShowsService _service;
  int page_number = 1;

  PopularShowsComponent(this._service);

  @override
  void ngOnInit() async {
    shows = await _service.getPopularShows(page_number);
  }

  void pageUp() async {
    page_number ++;
    shows = await _service.getPopularShows(page_number);
  }

  void pageDown() async {
    if(page_number > 1){
      page_number --;
      shows = await _service.getPopularShows(page_number);
    }
  }

  String showUrl(String name) => RoutePaths.show_details.toUrl(parameters: {nameParam: '$name'});

}
