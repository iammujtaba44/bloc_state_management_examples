import 'package:bloc_tutorial/login_handle.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppState {
  final bool isLoading;
  final LoginHandle? loginHandle;
  final Iterable<Note>? notes;
  final LoginErrors? loginError;

  const AppState.empty()
      : isLoading = false,
        loginHandle = null,
        notes = null,
        loginError = null;

  const AppState({
    required this.isLoading,
    required this.loginHandle,
    required this.notes,
    required this.loginError,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'loginHandle': loginHandle,
        'notes': notes,
        'loginError': loginError,
      }.toString();
}
