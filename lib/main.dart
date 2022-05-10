import 'package:bloc_tutorial/api/login_api.dart';
import 'package:bloc_tutorial/api/nots_api.dart';
import 'package:bloc_tutorial/bloc/actions.dart';
import 'package:bloc_tutorial/bloc/bloc.dart';
import 'package:bloc_tutorial/bloc/states.dart';
import 'package:bloc_tutorial/generic_dialog/generic_dialog.dart';
import 'package:bloc_tutorial/generic_dialog/loading_screen.dart';
import 'package:bloc_tutorial/login_handle.dart';
import 'package:bloc_tutorial/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'iterable_list_view.dart';
import 'login_view_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bloc Demo'),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            //loading screen

            if (appState.isLoading) {
              LoadingScreen.instance().show(context: context, text: pleaseWait);
            } else {
              LoadingScreen.instance().hide();
            }

            //Display Errors

            final loginError = appState.loginError;
            if (loginError != null) {
              showGenericDialog<bool>(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDiscription,
                optionsBuilder: () => {
                  ok: true,
                },
              );
            }

            //if we logged in but the fetch notes are null
            if (!appState.isLoading &&
                appState.loginError == null &&
                appState.loginHandle == const LoginHandle.foobar() &&
                appState.notes == null) {
              context.read<AppBloc>().add(
                    const NotesActions(),
                  );
            }
          },
          builder: (context, appState) {
            final notes = appState.notes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, passowrd) {
                  context.read<AppBloc>().add(
                        LoginAction(
                          email: email,
                          password: passowrd,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
