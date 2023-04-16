import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkour_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:parkour_app/bloc/auth_bloc/states.dart';
import 'package:parkour_app/view/authentication/login.dart';
import 'package:parkour_app/view/custom_drawer.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthenticationState>(builder: (context,state)
    {
print("here");
      if(state is Authenticated)
      {
        return CustomDrawer();
      }
      if(state is UnAuthenticated)
      {
        print("unauthenticated state reached here");
        return Login();
      }
      else if(state is Unknown){
        return Scaffold(body:Container());
      }
      else{
        return Scaffold(body:Container());
      }
    });
  }
}
