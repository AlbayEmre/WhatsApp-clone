import 'package:bloc_pattern_firebase_tut/Bloc/Chat/chat_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/User_bloc/user_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Models/chat_model.dart';
import 'package:bloc_pattern_firebase_tut/controller/User_uid_controller.dart';
import 'package:bloc_pattern_firebase_tut/view/chat_screen/widget/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;
  final String roomName;
  final int participantCount;

  ChatScreen({required this.roomId, required this.roomName, required this.participantCount});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final String userUid = GetUserInformation.getUserUid(); // Kullanıcı ID'si

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessages(widget.roomId));
    context.read<UserBlocBloc>().add(LoadUser(userUid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF), // Arka plan rengini değiştirdik
      appBar: AppBar(
        backgroundColor: Color(0xFF00796B), // App bar rengini değiştirdik
        iconTheme: IconThemeData(color: Colors.white), // Geri okunu beyaz yaptık
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.roomName,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), // Metin rengini beyaz yaptık
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.group, size: 16, color: Colors.white), // Katılımcı ikonu beyaz
                SizedBox(width: 4),
                Text(
                  '${widget.participantCount} Katılımcı',
                  style: TextStyle(fontSize: 14, color: Colors.white), // Katılımcı sayısı beyaz
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  final messages = state.allMessages;
                  messages.sort((a, b) =>
                      int.parse(a.timestamp).compareTo(int.parse(b.timestamp))); // Mesajları zamana göre sırala
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final bool isMine = message.userId == userUid;

                      return MessageBubble(message: message, isMine: isMine); // Mesaj kutusunu kullanıyoruz
                    },
                  );
                } else if (state is ChatError) {
                  return Center(child: Text('Henüz Sohbet Yok'));
                } else {
                  return Center(child: Text('Bilinmeyen bir hata oluştu.'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Mesajınızı yazın",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                BlocBuilder<UserBlocBloc, UserBlocState>(
                  builder: (context, userState) {
                    if (userState is UserLoaded) {
                      return IconButton(
                        icon: Icon(Icons.send, color: Color(0xFF00796B)),
                        onPressed: () {
                          final message = MessageModel(
                            content: _messageController.text,
                            timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
                            type: "text",
                            userFullName: userState.user.fullName ?? "Bilinmiyor",
                            userId: userUid,
                            userPhotoUrl: userState.user.userPicture ?? "", // Eğer kullanıcı fotoğrafı yoksa boş bırak
                          );
                          context.read<ChatBloc>().add(SendMessage(widget.roomId, message));
                          _messageController.clear();
                        },
                      );
                    } else {
                      return IconButton(
                        icon: Icon(Icons.send, color: Color(0xFF00796B)),
                        onPressed: null, // Kullanıcı yüklenmediyse gönderme
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
