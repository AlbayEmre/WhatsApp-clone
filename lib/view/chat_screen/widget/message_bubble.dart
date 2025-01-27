import 'package:bloc_pattern_firebase_tut/Models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMine;

  MessageBubble({required this.message, required this.isMine});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8), // Kenar boşlukları
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // İçerik dolgusunu küçülttük
        decoration: BoxDecoration(
          color: isMine ? Color(0xFFB2DFDB) : Color(0xFFCFD8DC), // Renkleri güncelledik
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isMine ? Radius.circular(12) : Radius.circular(0),
            bottomRight: isMine ? Radius.circular(0) : Radius.circular(12),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7, // Mesaj kutusu genişliğini sınırlandırıyoruz
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!isMine)
                  CircleAvatar(
                    backgroundImage: NetworkImage(message.userPhotoUrl),
                    radius: 12, // Profil resminin boyutunu küçülttük
                  ),
                if (!isMine) SizedBox(width: 8),
                Text(
                  message.userFullName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14), // Yazı tipi boyutunu küçülttük
                ),
              ],
            ),
            if (!isMine) SizedBox(height: 4), // Mesaj ile isim arasındaki boşluğu küçülttük
            Text(
              message.content,
              style: TextStyle(fontSize: 14), // Mesaj metni boyutunu küçülttük
            ),
            SizedBox(height: 4), // Mesaj metni ile saat arasındaki boşluğu küçülttük
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                //package intl
                DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(message.timestamp))),

                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
