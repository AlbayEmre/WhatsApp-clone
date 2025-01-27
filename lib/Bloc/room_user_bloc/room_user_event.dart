import 'package:bloc_pattern_firebase_tut/Models/Room_model.dart';
import 'package:equatable/equatable.dart';

// RoomEvent soyut sınıfı, BLoC için olayları tanımlar.
abstract class RoomUserEvent extends Equatable {
  const RoomUserEvent();

  @override
  List<Object> get props => [];
}

// Kullanıcıya ait sohbet odalarını yüklemek için olay.
class LoadUserRooms extends RoomUserEvent {
  /*final String userId;

  const LoadUserRooms(this.userId);

  @override
  List<Object> get props => [userId];*/
}

//  Sohbet odalarını yüklemek için olay.
//class LoadRooms extends RoomUserEvent {}

// Yeni bir sohbet odası eklemek için olay.
class AddUserRoom extends RoomUserEvent {
  final RoomModel room; // Eklenecek oda.

  const AddUserRoom(this.room);

  @override
  List<Object> get props => [room];
}

// Var olan bir sohbet odasını güncellemek için olay.
class UpdateUserRoom extends RoomUserEvent {
  final RoomModel room; // Güncellenecek oda.

  const UpdateUserRoom(this.room);

  @override
  List<Object> get props => [room];
}

// Var olan bir sohbet odasını silmek için olay.
class DeleteUserRoom extends RoomUserEvent {
  final String roomId;
  final String userId;

  const DeleteUserRoom(this.roomId, this.userId);

  @override
  List<Object> get props => [roomId, userId];
}

class SearchUserRooms extends RoomUserEvent {
  final String query;

  const SearchUserRooms(this.query);

  @override
  List<Object> get props => [query];
}
