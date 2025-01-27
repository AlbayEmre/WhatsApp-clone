import 'package:bloc_pattern_firebase_tut/Bloc/Chat/chat_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/room_bloc/room_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Models/Room_model.dart';
import 'package:bloc_pattern_firebase_tut/Repository/Chat_Repository.dart';
import 'package:bloc_pattern_firebase_tut/controller/User_uid_controller.dart';
import 'package:bloc_pattern_firebase_tut/view/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomListTile extends StatelessWidget {
  final RoomModel room;
  final String userUid = GetUserInformation.getUserUid(); // Kullanıcı ID'si

  RoomListTile({
    Key? key,
    required this.room,
    required Null Function() onJoinPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Kullanıcının odada olup olmadığını kontrol et
    bool isParticipant = room.participantUsers.contains(userUid); //odada bu kulanıcının id si varmı bak

    void _handleJoinRoom() {
      // Eğer kullanıcı odaya katılmamışsa, katılma işlemi yap
      if (!isParticipant) {
        // participantUsers listesine kullanıcıyı ekle
        room.participantUsers.add(userUid);

        // Oda güncelleme olayını tetikle
        BlocProvider.of<RoomBlocBloc>(context).add(UpdateRoom(room)); //odayı güncelleme  TRİGERİ TETİKLE
      }
    }

    void _navigateToChatScreen() {
      if (isParticipant) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ChatBloc(chatRepository: ChatRepository()),
              child: ChatScreen(
                roomId: room.roomId,
                roomName: room.roomName,
                participantCount: room.participantUsers.length,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Bu odaya katılmanız gerekiyor."),
          ),
        );
      }
    }

    return InkWell(
      onTap: _navigateToChatScreen, // Tıklama ile chat ekranına yönlendirme
      child: Card(
        elevation: 6,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isParticipant
              ? BorderSide(color: Colors.green, width: 4) // Katılımcıysa yeşil kalın bir sınır
              : BorderSide.none,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Eğer fotoğraf varsa göster, yoksa boş geç
            if (room.roomCoverImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  room.roomCoverImage,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Oda adı ve açıklama
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.roomName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        room.roomDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  // Katılımcı sayısını gösteren ikon ve sayı
                  Row(
                    children: [
                      Icon(
                        Icons.group,
                        color: Colors.blueAccent,
                        size: 28,
                      ),
                      SizedBox(width: 4),
                      Text(
                        room.participantUsers.length.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Eğer kullanıcı odada değilse katıl butonunu göster
            if (!isParticipant)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 2.0), // Bu değerleri küçülttük
                child: ElevatedButton(
                  onPressed: _handleJoinRoom,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.orange.withOpacity(0.5),
                    elevation: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.rocket_launch, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "Hemen Katıl",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
