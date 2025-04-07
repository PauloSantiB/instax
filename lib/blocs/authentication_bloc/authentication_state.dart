part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unuathenticated, unknown }

class AuthenticationState extends Equatable{

  final AuthenticationStatus status;
  final User? user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  /// No Information about the [AuthenticationStatus] of the current user.
   const AuthenticationState.unkown() : this._();

   /// Current user is [authenticated].
   /// 
   ///  It takes a [MyUser] property represe
   const AuthenticationState.authenticated(User user) : this._(status:  AuthenticationStatus.authenticated, user: user);

   /// Current user is[unauthenticated].
   const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unuathenticated);

  @override
  List<Object?> get props => [status, user];
}
