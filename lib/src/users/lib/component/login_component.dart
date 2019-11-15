import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:tvShows/src/users/lib/service/login_service.dart';

@Component (
  selector: 'display-results',
  directives: [coreDirectives,formDirectives, routerDirectives],
  templateUrl: 'login_component.html',
)
class LoginComponent {
  String username, passwordz, out;
  bool success = false, submitted = false;

  final LoginService _loginService;

  LoginComponent(this._loginService);


  Map<String, bool> setCssValidityClass(NgControl control) {
    final validityClass = control.valid == true ? 'is-valid' : 'is-invalid';
    return {validityClass: true};
  }

  Future<void> onSubmit() async {
    submitted = true;
    out = await _loginService.login(username, passwordz);
    if(out != null) {
      success = true;
      window.localStorage['id'] = out;
      window.localStorage['name'] = username;
    } else {
      success = false;
    }
  }
}
