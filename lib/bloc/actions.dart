import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppAction {
  const AppAction();
}

@immutable
class LoginAction extends AppAction {
  final String email;
  final String password;

  const LoginAction({required this.email, required this.password});
}

@immutable
class NotesActions extends AppAction {
  // final String email;
  // final String password;

  const NotesActions();
}
