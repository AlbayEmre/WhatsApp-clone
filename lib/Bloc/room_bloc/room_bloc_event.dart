part of 'room_bloc_bloc.dart';

//!UI ile köprü ve her biri triger

abstract class RoomBlocEvent extends Equatable {
  const RoomBlocEvent();

  @override
  List<Object> get props => [];
}

//Odaların yüklenmesini başlatmak için bir olay [UI da bunu trigirize ediceğiz]
class LoadRooms extends RoomBlocEvent {}

//todo : UI dan bir oda alarak bunu stateye ileticeğiz
class AddRoom extends RoomBlocEvent {
  final RoomModel room; //todo : UI dan aldığımız oda

  const AddRoom(this.room);

  @override
  List<Object> get props => [room];
}

//todo :Bir odayı güncellerken UI dan veri alıp bunu stateye vericeğiz
class UpdateRoom extends RoomBlocEvent {
  final RoomModel room; //todo: UI dan aldığımız veri

  const UpdateRoom(this.room);

  @override
  List<Object> get props => [room];
}

//todo: Bir oda silmek için
class DeleteRoom extends RoomBlocEvent {
  //!UI dan alıdnan ve state ile köprü gören kısım
  final String roomId; //Sileincek oda
  final String userId; //Kim tafaından silinecek

  DeleteRoom(this.roomId, this.userId);

  @override
  List<Object> get props => [userId, roomId];
}

//Bir oda aramak
class SearchRooms extends RoomBlocEvent {
  final String query;

  SearchRooms(this.query); //Aranacak oda için anahtar kelime

  @override
  List<Object> get props => [query];
}

//!NOT :Ekranda bir işlem başlatamak için burda olay triger tanımlıyoruz

//? 5 tane trigerimiz var 
