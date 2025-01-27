import 'package:bloc/bloc.dart';
import 'package:bloc_pattern_firebase_tut/Models/User_Model.dart';
import 'package:bloc_pattern_firebase_tut/Repository/user_repository.dart';
import 'package:bloc_pattern_firebase_tut/controller/User_uid_controller.dart';
import 'package:equatable/equatable.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBlocBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final UserRepository _userRepository;

  //Bu providere işem yapması için bu repoyu vermek gerekli
  UserBlocBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitial()) {
    //Buda 4 tane fonksyon yazdık
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserProfiePisture>(_onUpdateUserProfilePicture);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  void _onLoadUser(LoadUser event, Emitter<UserBlocState> emit) async {
    emit(UserLoading()); //Kullanıcı yüklenmeden önce Yükleniyor durumunu yayınla
    try {
      final user = await _userRepository.getUser(event.userId); //UI dan gelen UserId ile kullanıcıyı çek
      if (user != null) {
        emit(UserLoaded(user)); //Eyer kullanıcı boş deyilse mevcut olan kullanıcıyı yayınla
      } else {
        emit(UserError("User not found"));
      }
    } catch (e) {
      emit(UserError(e.toString())); //Eyer bir hata olursa bu hatayı yayınla
    }
  }

  //Kulanıcıyı güncellemek için bunu kullan
  void _onUpdateUser(UpdateUser event, Emitter<UserBlocState> emit) async {
    emit(UserLoading());
    try {
      await _userRepository.updateUser(event.user);
      emit(UserLoaded(event.user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onUpdateUserProfilePicture(UpdateUserProfiePisture event, Emitter<UserBlocState> emit) async {
    emit(UserLoading()); //Kullanıcı fotoğrafı güncellerken

    try {
      // todo: Kullanıcının profil fortoğrafını güncellemek için GetUserInformation.getUserUid()--> ile güncel kullanıcının uid deyerini al
      await _userRepository.updateUserPicture(GetUserInformation.getUserUid(), event.profilePicture); //!Güncelle
      final user = await _userRepository.getUser(GetUserInformation.getUserUid()); //!Güncel kullanıcıyı al

      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UserError("Failed to update profile picture"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onUpdateUserProfile(UpdateUserProfile event, Emitter<UserBlocState> emit) async {
    emit(UserLoading()); //Profil güncelerken once yükleniyor yap

    try {
      await _userRepository.updateUserProfile(
          GetUserInformation.getUserUid(), event.fullName, event.userName, event.userEmail);
      final user = await _userRepository.getUser(GetUserInformation.getUserUid());
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UserError("Failed to update user profile"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
