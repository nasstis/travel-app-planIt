part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthState {
  final AuthStatus status;
  final MyUser? user;
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  AuthState.unknown() : this._();

  AuthState.authenticated(MyUser myUser)
      : this._(
          status: AuthStatus.authenticated,
          user: myUser,
        );

  AuthState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );
}
