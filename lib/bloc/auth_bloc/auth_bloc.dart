import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkour_app/data/auth_repo.dart';
import 'events.dart';
import 'states.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState>
{

  AuthBloc(this._repository):super(Unknown())
  {

    on<LoggedIn>((event, emit)
    {
emit(Authenticated());
    });
    on<LoggedOut>((event, emit) => emit(UnAuthenticated()));

    _authenticationStatusSubscription = _repository.status.listen((status) {
      //Listens to the auth repository status stream to trigger sign in and sign out events
      print("called");
      if (status == false){
        add(LoggedOut());
      }
      else
      if(status == true)
      {
        add(LoggedIn());
      }
    });
  }

  final AuthRepo _repository;
  late StreamSubscription<bool> _authenticationStatusSubscription;

}