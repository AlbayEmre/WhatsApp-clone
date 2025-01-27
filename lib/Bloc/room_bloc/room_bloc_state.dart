part of 'room_bloc_bloc.dart';

//!Odaların Verileri
abstract class RoomBlocState extends Equatable {
  const RoomBlocState();

  @override
  List<Object> get props => [];
}

//Oda verilerini yüklerken ki durum
class RoomLoading extends RoomBlocState {} //Bloc içine giren ilk durum

//Odalar yüklendiğinde
class RoomLoaded extends RoomBlocState {
  final List<RoomModel> roomss;

  RoomLoaded(this.roomss);

  @override
  List<Object> get props => [roomss];
}

//Filitrelenmiş odalar burda tutulacak
class FilteredRoomsLoaded extends RoomBlocState {
  final List<RoomModel> filteredRooms;

  FilteredRoomsLoaded(this.filteredRooms);

  @override
  List<Object> get props => [filteredRooms];
}

//Bir hata olduğunda
class RoomError extends RoomBlocState {}

//!Bunlar da ise event calışınca oluşan olay soncu ne olsun olları tanımlıyoruz
//todo :Burdaki verielr UI da görünecek
