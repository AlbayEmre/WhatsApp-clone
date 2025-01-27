import 'package:bloc_pattern_firebase_tut/Models/Room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//!File base ile iletişim kısmı --> Repository
// on<LoadRooms>(_onLoadRooms); // TÜm odaları çekmek için metod --> Steam
//   on<AddRoom>(_onAddRoom); // Oda ekalemk için metod --> Future
//   on<UpdateRoom>(_onUpdateRoom);// oda güncellemek için metod --> Future
//   on<DeleteRoom>(_onDeleteRoom);//Oda silmek için metod --> Future
//   on<SearchRooms>(_onSearchRooms);//Bunu provider sayasında da yapabilirz
class RoomRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection("rooms"); //!Get data collection

  Future<void> addRoom(RoomModel room) {
    return collection.doc(room.roomId).set(room.toJson()); //--> NoSQL olarak kaydet
  }

  Future<void> updateRooms(RoomModel room) {
    //Oda ıd ile bul güncellemesini yap
    return collection.doc(room.roomId).update(room.toJson()).then((_) => print("Room Updated"))
      ..catchError((error) => print("Falied to update room: $error"));
  }

  Future<void> deleteRoom(String id) {
    return collection.doc(id).delete(); //void dönecek zaten
  }

  //Kullanıcının şahsi odaları
  Stream<List<RoomModel>> getUserRooms(String userId) {
    //Eyer ki "creatorUser = userId" ise bu oda o kullanıcıya ayittir ve bu odaları çek
    return collection.where("creatorUser", isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => RoomModel.fromSnapshot(doc)).toList();
    });
  }

  //Tüm dahil olduğu odalar çek
  Stream<List<RoomModel>> getRooms() {
    //Tüm odaları çek
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => RoomModel.fromSnapshot(doc)).toList();
    });
  }
}
