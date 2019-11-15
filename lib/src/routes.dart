import 'package:angular_router/angular_router.dart';
import 'package:tvShows/src/route_paths.dart';
import 'package:tvShows/src/tv_show_list/lib/component/display_results_component.template.dart' as display_results_template;
import 'package:tvShows/src/tv_show_list/lib/component/popular_shows_component.template.dart' as popular_shows_template;
import 'package:tvShows/src/tv_shows_details/lib/component/tv_show_component.template.dart' as tv_show_details_template;
import 'package:tvShows/src/users/lib/component/login_component.template.dart' as login_template;
import 'package:tvShows/src/users/lib/component/user_lists_component.template.dart' as user_list_template;

class Routes {
  static final shows = RouteDefinition(
    routePath: RoutePaths.shows,
    component: popular_shows_template.PopularShowsComponentNgFactory,
  );
  static final show_details = RouteDefinition(
    routePath: RoutePaths.show_details,
    component: tv_show_details_template.TvShowComponentNgFactory,
  );
  static final display_results = RouteDefinition(
    routePath: RoutePaths.display_results,
    component: display_results_template.DisplayResultsComponentNgFactory,
  );
  static final login = RouteDefinition(
    routePath: RoutePaths.login,
    component: login_template.LoginComponentNgFactory,
  );
  static final user_list = RouteDefinition(
    routePath: RoutePaths.user_list,
    component: user_list_template.UserListComponentNgFactory,
  );
  static final all = <RouteDefinition>[
    shows,
    show_details,
    display_results,
    login,
    user_list,
  ];
}
