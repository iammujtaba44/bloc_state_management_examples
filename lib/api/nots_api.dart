import 'package:flutter/foundation.dart' show immutable;

import '../login_handle.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  });
}

@immutable
class NotesApi implements NotesApiProtocol {
  // const NotesApi._sharedInstance();
  // static const NotesApi _instance = NotesApi._sharedInstance();
  // factory NotesApi.instance() => _instance;
  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => loginHandle == const LoginHandle.foobar() ? mockNotes : null,
      );
}
