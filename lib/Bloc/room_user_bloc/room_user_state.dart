import 'package:bloc_pattern_firebase_tut/Models/Room_model.dart';
import 'package:equatable/equatable.dart';

// RoomState soyut sınıfı, BLoC için durumları tanımlar.
abstract class RoomUserState extends Equatable {
  const RoomUserState();

  @override
  List<Object> get props => [];
}

// Oda verileri yüklenirken durum.
class RoomUserLoading extends RoomUserState {}

// Kullanıcı oda verileri yüklendiğinde durum.
class RoomUserLoaded extends RoomUserState {
  final List<RoomModel> rooms; // Yüklenen odalar.

  const RoomUserLoaded(this.rooms);

  @override
  List<Object> get props => [rooms];
}

/*// Oda verileri yüklendiğinde durum.
class RoomLoaded extends RoomUserState {
  final List<RoomModel> roomss; // Yüklenen odalar.

  const RoomLoaded(this.roomss);

  @override
  List<Object> get props => [roomss];
}*/

// Bir hata oluştuğunda durum.
class RoomUserError extends RoomUserState {}

class FilteredRoomsUserLoaded extends RoomUserState {
  final List<RoomModel> filteredRooms;

  const FilteredRoomsUserLoaded(this.filteredRooms);

  @override
  List<Object> get props => [filteredRooms];
}
