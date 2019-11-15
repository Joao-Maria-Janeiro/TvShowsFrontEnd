import 'package:angular_router/angular_router.dart';
const nameParam = 'name';

class RoutePaths {
  static final shows = RoutePath(path: 'shows/');
  static final show_details = RoutePath(path: '${shows.path}/:$nameParam');
  static final display_results = RoutePath(path: '${shows.path}/results/:$nameParam');
  static final login = RoutePath(path: 'login/');
  static final user_list = RoutePath(path: 'userlist/:$nameParam');
}
String getName(Map<String, String> parameters) {
  String name = parameters[nameParam];
  name = name.replaceAll(' ', '-');
  return name == null ? null : name;
}
