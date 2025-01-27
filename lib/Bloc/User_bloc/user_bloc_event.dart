part of 'user_bloc_bloc.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();

  @override
  List<Object> get props => [];
}

// todo : Bunlar UI da fonksyon trigire etmek ve içine aldığı parametre ile bloc sısıfıdna işem yapdırır

//Kulanıcıyı yükle
//Bu bir triger ve Ui dan aldiği userId ile işemler yapar
class LoadUser extends UserBlocEvent {
  final String userId;
  const LoadUser(this.userId);

  @override
  List<Object> get props => [userId];
}

//ui dan çek ve triger ile işem yap ve stete yi güncelemek için ver
class UpdateUser extends UserBlocEvent {
  final UserModel user;

  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateUserProfiePisture extends UserBlocEvent {
  final String profilePicture;

  const UpdateUserProfiePisture(this.profilePicture);

  @override
  List<Object> get props => [profilePicture];
}

class UpdateUserProfile extends UserBlocEvent {
  final String fullName;
  final String userName;
  final String userEmail;

  const UpdateUserProfile({required this.fullName, required this.userEmail, required this.userName});

  @override
  List<Object> get props => [fullName, userEmail, userName];
}
