import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkour_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:parkour_app/bloc/auth_bloc/states.dart';
import 'package:parkour_app/data/auth_repo.dart';
import 'package:parkour_app/data/user_model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      TextButton(onPressed: ()
      {
        RepositoryProvider.of<AuthRepo>(context).login("hamdaan.a.sawar@gmail.com","world");
      }, child: const Text("Action")),
  ],),);
  }
}
