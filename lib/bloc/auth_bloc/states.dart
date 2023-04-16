abstract class AuthenticationState
{}

class Authenticated extends AuthenticationState
{}

class UnAuthenticated extends AuthenticationState
{}

class Unknown extends AuthenticationState
{}
class ErrorState extends AuthenticationState
{
  final String error;

  ErrorState(this.error);

}

