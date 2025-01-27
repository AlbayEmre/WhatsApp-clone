part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthBlocState {} //Uygulama başlama durumu

class AuthLoading extends AuthBlocState {} //Yükleiniyor durumu

// AuthAuthenticated, kullanıcının başarılı bir şekilde doğrulandığını temsil eder.
class AuthAuthenticated extends AuthBlocState {}

// AuthAuthenticated, kullanıcının başarılı bir şekilde doğrulandığını temsil eder.
class AuthOTP extends AuthBlocState {
  final String phoneNumber;
  AuthOTP({required this.phoneNumber});
}

// AuthUnauthenticated, kullanıcının doğrulanmadığını veya çıkış yaptığını temsil eder.
class AuthUnauthenticated extends AuthBlocState {}

// AuthError, bir doğrulama hatası olduğunu temsil eder.
class AuthError extends AuthBlocState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
