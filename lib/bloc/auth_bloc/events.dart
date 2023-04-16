import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthenticationEvent {
}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {

}
