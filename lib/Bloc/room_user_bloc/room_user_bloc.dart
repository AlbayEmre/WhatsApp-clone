import 'package:bloc_pattern_firebase_tut/Models/Room_model.dart';
import 'package:bloc_pattern_firebase_tut/Repository/Chat_Repository.dart';
import 'package:bloc_pattern_firebase_tut/Repository/room_repository.dart';
import 'package:bloc_pattern_firebase_tut/controller/User_uid_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'room_user_event.dart';
import 'room_user_state.dart';

// RoomBloc sınıfı, BLoC desenini uygular ve olayları yönetir.
class RoomUserBloc extends Bloc<RoomUserEvent, RoomUserState> {
  final RoomRepository roomRepository;
  final ChatRepository chatRepository;

  RoomUserBloc(this.chatRepository, {required this.roomRepository}) : super(RoomUserLoading()) {
    on<LoadUserRooms>(_onLoadUserRooms); // LoadUserRooms olayını dinliyor.
    //on<LoadRooms>(_onLoadRooms); // LoadRooms olayını dinliyor.
    on<AddUserRoom>(_onAddUserRoom); // AddRoom olayını dinliyor.
    on<UpdateUserRoom>(_onUpdateUserRoom); // UpdateRoom olayını dinliyor.
    on<DeleteUserRoom>(_onDeleteUserRoom); // DeleteRoom olayını dinliyor.
    on<SearchUserRooms>(_onSearchUserRooms); // SearchRooms olayını dinliyor.
  }

  // LoadUserRooms olayını işleyen metot.
  void _onLoadUserRooms(LoadUserRooms event, Emitter<RoomUserState> emit) async {
    String userUid = GetUserInformation.getUserUid();
    emit(RoomUserLoading());
    try {
      await emit.forEach<List<RoomModel>>(
        roomRepository.getUserRooms(userUid),
        onData: (rooms) => RoomUserLoaded(rooms),
        onError: (_, __) => RoomUserError(),
      );
    } catch (_) {
      emit(RoomUserError());
    }
  }

  // AddRoom olayını işleyen metot.
  void _onAddUserRoom(AddUserRoom event, Emitter<RoomUserState> emit) async {
    try {
      await roomRepository.addRoom(event.room); // Oda ekle.
      add(LoadUserRooms()); // Odaları yeniden yükle.
    } catch (_) {
      emit(RoomUserError());
    }
  }

  // UpdateRoom olayını işleyen metot.
  void _onUpdateUserRoom(UpdateUserRoom event, Emitter<RoomUserState> emit) async {
    try {
      await roomRepository.updateRooms(event.room); // Odayı güncelle.
      add(LoadUserRooms()); // Odaları yeniden yükle.
    } catch (_) {
      emit(RoomUserError());
    }
  }

  // DeleteRoom olayını işleyen metot.
  void _onDeleteUserRoom(DeleteUserRoom event, Emitter<RoomUserState> emit) async {
    try {
      await roomRepository.deleteRoom(event.roomId); // Odayı sil.
      //await chatRepository.deleteRoomMessages(event.roomId);
      add(LoadUserRooms()); // Odaları yeniden yükle.
    } catch (_) {
      emit(RoomUserError());
    }
  }

  // SearchRooms olayını işleyen metot.
  void _onSearchUserRooms(SearchUserRooms event, Emitter<RoomUserState> emit) {
    final currentState = state;

    if (currentState is RoomUserLoaded) {
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(RoomUserLoaded(currentState.rooms));
      } else {
        final filteredRooms = currentState.rooms.where((room) {
          return room.roomName.toLowerCase().contains(query);
        }).toList();
        emit(RoomUserLoaded(filteredRooms));
      }
    }
  }
}
