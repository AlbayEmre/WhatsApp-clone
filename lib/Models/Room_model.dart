import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final List<dynamic> adminUsers;
  final Timestamp atCreate;
  final Timestamp atSubscriptionPriceUpdate;
  final Timestamp atUpdate;
  final List<dynamic> bannedUsers;
  final String creatorUser;
  final bool isActive;
  final List<dynamic> participantUsers;
  final String roomCoverImage;
  final String roomDescription;
  final String roomId;
  final String roomImage;
  final String roomName;
  final String roomTitle;
  //final int subscriptionPrice;

  RoomModel({
    required this.adminUsers,
    required this.atCreate,
    required this.atSubscriptionPriceUpdate,
    required this.atUpdate,
    required this.bannedUsers,
    required this.creatorUser,
    required this.isActive,
    required this.participantUsers,
    required this.roomCoverImage,
    required this.roomDescription,
    required this.roomId,
    required this.roomImage,
    required this.roomName,
    required this.roomTitle,
    //required this.subscriptionPrice,
  });
//Bu metod, Firestore’dan alınan DocumentSnapshot’ı UserModel nesnesine dönüştürür.
//Firestore’dan veri çekerken kullanılır.
  factory RoomModel.fromSnapshot(DocumentSnapshot snap) {
    var res = snap.data() as Map<String, dynamic>;

    return RoomModel(
      adminUsers: res["adminUsers"] ?? [],
      atCreate: res["atCreate"] ?? Timestamp.now(),
      atSubscriptionPriceUpdate: res["atSubscriptionPriceUpdate"] ?? Timestamp.now(),
      atUpdate: res["atUpdate"] ?? Timestamp.now(),
      bannedUsers: res["bannedUsers"] ?? [],
      creatorUser: res["creatorUser"] ?? "",
      isActive: res["isActive"] ?? false,
      participantUsers: res["participantUsers"] ?? [],
      roomCoverImage: res["roomCoverImage"] ?? "",
      roomDescription: res["roomDescription"] ?? "",
      roomId: res["roomId"] ?? "",
      roomImage: res["roomImage"] ?? "",
      roomName: res["roomName"] ?? "",
      roomTitle: res["roomTitle"] ?? "",
      //subscriptionPrice: res["subscriptionPrice"] ?? 0,
    );
  }
//Veriyi Firestore’a kaydederken kullanılır.
//Bu metod, UserModel nesnesini JSON formatına dönüştürür.
//JSON formatı, veriyi Firestore gibi bir NoSQL veritabanına kaydetmek için kullanılır.
  Map<String, dynamic> toJson() {
    return {
      'adminUsers': adminUsers,
      'atCreate': atCreate,
      'atSubscriptionPriceUpdate': atSubscriptionPriceUpdate,
      'atUpdate': atUpdate,
      'bannedUsers': bannedUsers,
      'creatorUser': creatorUser,
      'isActive': isActive,
      'participantUsers': participantUsers,
      'roomCoverImage': roomCoverImage,
      'roomDescription': roomDescription,
      'roomId': roomId,
      'roomImage': roomImage,
      'roomName': roomName,
      'roomTitle': roomTitle,
      //'subscriptionPrice': subscriptionPrice,
    };
  }
}
