part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthBlocEvent {}

//Kulanıcı girş yapmaya calişinca bu tetikenir
class LoggedIn extends AppStarted {
  final String phoneNumber;

  LoggedIn({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtp extends AppStarted {
  final String phoneNumber;
  final String otp;

  VerifyOtp({required this.phoneNumber, required this.otp});

  @override
  List<Object> get props => [phoneNumber, otp];
}

// LoggedOut event'i, kullanıcı çıkış yaptığında tetiklenir.
//!Bu kısım tetikleninde auth_block kısımda o durum çalışır
class LoggedOut extends AppStarted {}
