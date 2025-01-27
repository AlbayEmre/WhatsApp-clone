part of 'user_bloc_bloc.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserBlocState {}

class UserLoading extends UserBlocState {} //Kulanıcı verielri yükeniyorken ... nolacak şimdi

class UserLoaded extends UserBlocState {
  final UserModel user;

  const UserLoaded(this.user);
  @override
  List<Object> get props => [user];
} //Kullanıc verileri yüklenirken nolacak şimdi

class UserUpdated extends UserBlocState {} //Kulanıcı verielri başarılı bier şekidle güncellendiği zamman ne olacak

class UserError extends UserBlocState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

class UserProfilePictureUpdated extends UserBlocState {
  final String profilePicture;
  const UserProfilePictureUpdated(this.profilePicture);

  @override
  List<Object> get props => [profilePicture];
}

class UserProfileUpdated extends UserBlocState {
  //Profil güncellendiğinde bu veriler olacak
  final String fullName;
  final String username;
  final String email;

  const UserProfileUpdated({required this.email, required this.fullName, required this.username});

  @override
  List<Object> get props => [fullName, username, email];
}
