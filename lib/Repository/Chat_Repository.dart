import 'package:bloc_pattern_firebase_tut/Models/chat_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

//Zaten bu sürekli akışı dineldinden tüm güncellemeleri bu yapacak
  //todo : Anlık mesajları dinle ve tüm mesajları çek
//!Stream bir akış sağlar yeni bir veri geldiğidne anlık güdneler ve o veriyi dönderir {Sürekli bir akış var olası gekli burda}
  Stream<List<MessageModel>> getMessages(String roomId) {
    DatabaseReference ref = _database.ref("RoomMessages/$roomId");
    return ref.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      final List<MessageModel> messages = [];
      data.forEach((key, value) {
        messages.add(MessageModel.fromMap(value));
      });

      return messages;
    });
  }

  //TODO :Tek seferlik olay bu yuzden Future olacak
  Future<void> sendMessage(String roomId, MessageModel message) async {
    DatabaseReference ref = _database.ref("RoomMessages/$roomId");
    await ref.set(message.toMap());
  }

// Belirli bir roomId'ye ait sohbet dökümanını silmek için
  Future<void> deleteRoomMessages(String roomId) async {
    DatabaseReference ref = _database.ref("RoomMessages/$roomId");
    await ref.remove();
  }

  //Bir mesajı herkezden sil [HERKEZDEN SİL]
  Future<void> deleteMessage(String roomId, String messageId) async {
    DatabaseReference ref = _database.ref("RoomMessages/$roomId/$messageId");
    await ref.remove();
  }

  //Sadece benden sil[BENDEN SİL]
  Future<void> deleteMessageForUser(String roomId, String messageId, String userId) async {
    DatabaseReference ref = _database.ref("RoomMessages/$roomId/deletedMessages/$userId/$messageId");
    await ref.set(true);
  }
}
