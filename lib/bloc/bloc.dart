import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/api/login_api.dart';
import 'package:bloc_tutorial/api/nots_api.dart';
import 'package:bloc_tutorial/bloc/actions.dart';
import 'package:bloc_tutorial/bloc/states.dart';

import '../login_handle.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>(
      (event, emit) async {
        emit(
          const AppState(
            isLoading: true,
            loginHandle: null,
            notes: null,
            loginError: null,
          ),
        );
        final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password,
        );
        emit(
          AppState(
            isLoading: false,
            loginError: loginHandle == null ? LoginErrors.invaildHandle : null,
            loginHandle: loginHandle,
            notes: null,
          ),
        );
      },
    );
    on<NotesActions>(
      (event, emit) async {
        emit(
          AppState(
            isLoading: true,
            loginHandle: state.loginHandle,
            notes: null,
            loginError: null,
          ),
        );
        final loginHandle = state.loginHandle;

        /// When we have Invaild LoginHandle, we don't need to fetch notes.
        if (loginHandle != const LoginHandle.foobar()) {
          emit(
            AppState(
              isLoading: false,
              loginError: LoginErrors.invaildHandle,
              loginHandle: loginHandle,
              notes: null,
            ),
          );
          return;
        }

        /// When we have vaild login handle, we can get notes.
        final notes = await notesApi.getNotes(
          loginHandle: loginHandle!,
        );

        emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: loginHandle,
            notes: notes,
          ),
        );
      },
    );
  }
}
