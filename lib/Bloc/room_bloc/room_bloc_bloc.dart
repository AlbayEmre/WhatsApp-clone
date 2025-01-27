import 'package:bloc/bloc.dart';
import 'package:bloc_pattern_firebase_tut/Models/Room_model.dart';
import 'package:bloc_pattern_firebase_tut/Repository/room_repository.dart';
import 'package:equatable/equatable.dart';

part 'room_bloc_event.dart';
part 'room_bloc_state.dart';

class RoomBlocBloc extends Bloc<RoomBlocEvent, RoomBlocState> {
  final RoomRepository _roomRepository;

  RoomBlocBloc({required RoomRepository roomRepository})
      : _roomRepository = roomRepository, //Providre gelen repoyu buraya ver
        super(RoomLoading()) {
    on<LoadRooms>(_onLoadRooms);
    on<AddRoom>(_onAddRoom);
    on<UpdateRoom>(_onUpdateRoom);
    on<DeleteRoom>(_onDeleteRoom);
    on<SearchRooms>(_onSearchRooms);
  }

  void _onLoadRooms(LoadRooms event, Emitter<RoomBlocState> emit) async {
    emit(RoomLoading()); // Yüklenme durumunu yayınla bir bekleme işlemimiz olacak
    try {
      //Emit ile fonsyon çalıştıe ve her bir elemana foreach ile veriyi aktar
      await emit.forEach<List<RoomModel>>(
        _roomRepository.getRooms(),
        onData: (rooms) => RoomLoaded(rooms), //!Veri her geldiğinde üsütüne ekle
        onError: (a, b) => RoomError(), //Bu durmumu yayınlar
      );
    } catch (_) {
      emit(RoomError());
    }
  }

  void _onAddRoom(AddRoom event, Emitter<RoomBlocState> emit) async {
    try {
      emit(RoomLoading()); //oda eklerken bekleme ekle
      await _roomRepository.addRoom(event.room); //!Yeni oda ekle
      add(LoadRooms()); //Yeni bir oda ekleninde tüm odaları tekrar baştan yükle
    } catch (_) {
      emit(RoomError());
    }
  }

  void _onUpdateRoom(UpdateRoom event, Emitter<RoomBlocState> emit) async {
    try {
      emit(RoomLoading());
      await _roomRepository.updateRooms(event.room); //Odayı güncelle
      add(LoadRooms()); //Odayı güncelle ve odayı tekrar baştan yükle
    } catch (_) {
      emit(RoomError());
    }
  }

  void _onDeleteRoom(DeleteRoom event, Emitter<RoomBlocState> emit) async {
    try {
      emit(RoomLoading());
      await _roomRepository.deleteRoom(event.roomId); //Odayı sil
      add(LoadRooms()); //Sonra odayı baştan yükle
    } catch (_) {
      emit(RoomError());
    }
  }

  void _onSearchRooms(SearchRooms event, Emitter<RoomBlocState> emit) {
    RoomBlocState currentState = state; //Bu bizim ilk durumuuz filitrelerken karışmasın diye

    if (currentState is RoomLoaded) //Eyer odalar yüklendi ise işeme başla
    {
      final query = event.query.toLowerCase(); //Gelen sorguyu küçük harf yap

      if (query.isEmpty) {
        emit(RoomLoaded(currentState.roomss)); //Eyer ki
      } else {
        final fillterRooms = currentState.roomss.where((room) {
          return room.roomName.toLowerCase().contains(query);
        }).toList();

        emit(RoomLoaded(fillterRooms)); //Filitrelenmiş veriyi yayınla
      }
    }
  }
}
