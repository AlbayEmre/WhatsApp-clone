//Mesajlaşma için geken tüm veriler
class MessageModel {
  final String content;
  final String timestamp;
  final String type;
  final String userFullName;
  final String userId;
  final String userPhotoUrl; // Kullanıcı fotoğraf URL'si

  MessageModel({
    required this.content,
    required this.timestamp,
    required this.type,
    required this.userFullName,
    required this.userId,
    required this.userPhotoUrl, // Kullanıcı fotoğraf URL'si
  });

  factory MessageModel.fromMap(Map<dynamic, dynamic> map) {
    return MessageModel(
      content: map['content'],
      timestamp: map['timestamp'].toString(),
      type: map['type'],
      userFullName: map['userFullName'],
      userId: map['userId'],
      userPhotoUrl: map['userPhotoUrl'] ?? '', // Kullanıcı fotoğraf URL'si
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'timestamp': timestamp,
      'type': type,
      'userFullName': userFullName,
      'userId': userId,
      'userPhotoUrl': userPhotoUrl, // Kullanıcı fotoğraf URL'si
    };
  }
}
