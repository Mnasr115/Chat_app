part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {

  String errorMessage;

  LoginFailure({required this.errorMessage});
}


class RegisterSuccess extends AuthState {}
class RegisterLoaded extends AuthState {}
class RegisterFailure extends AuthState {

  String errorMessage;

  RegisterFailure({required this.errorMessage});

}