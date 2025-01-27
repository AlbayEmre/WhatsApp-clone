import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String fullName;
  final String userName;
  final String userEmail;
  final String phoneNumber;
  final String userPicture;
  final String country;
  final String language;
  final bool premium;
  final Timestamp createDate;
  final Timestamp pricingDate;
  final List<dynamic> crateChats;
  final List<dynamic> attendChats;
  final List<dynamic> tokens;

  UserModel({
    required this.userId,
    required this.fullName,
    required this.userName,
    required this.userEmail,
    required this.phoneNumber,
    required this.userPicture,
    required this.country,
    required this.language,
    required this.premium,
    required this.createDate,
    required this.pricingDate,
    required this.crateChats,
    required this.attendChats,
    required this.tokens,
  });
//Bu metod, Firestore’dan alınan DocumentSnapshot’ı UserModel nesnesine dönüştürür.
//Firestore’dan veri çekerken kullanılır.
  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var res = snap.data() as Map<String, dynamic>;

    return UserModel(
      userId: res["userId"] ?? "",
      fullName: res["fullName"] ?? "",
      userName: res["userName"] ?? "",
      userEmail: res["userEmail"] ?? "",
      phoneNumber: res["phoneNumber"] ?? "",
      userPicture: res["userPicture"] ?? "",
      country: res["country"] ?? "",
      language: res["language"] ?? "",
      premium: res["premium"] ?? false,
      createDate: res["createDate"] ?? Timestamp.now(),
      pricingDate: res["pricingDate"] ?? Timestamp.now(),
      crateChats: res["crateChats"] ?? [],
      attendChats: res["attendChats"] ?? [],
      tokens: res["tokens"] ?? [],
    );
  }
//Veriyi Firestore’a kaydederken kullanılır.
//Bu metod, UserModel nesnesini JSON formatına dönüştürür.
//JSON formatı, veriyi Firestore gibi bir NoSQL veritabanına kaydetmek için kullanılır.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'userName': userName,
      'userEmail': userEmail,
      'phoneNumber': phoneNumber,
      'userPicture': userPicture,
      'country': country,
      'language': language,
      'premium': premium,
      'createDate': createDate,
      'pricingDate': pricingDate,
      'crateChats': crateChats,
      'attendChats': attendChats,
      'tokens': tokens,
    };
  }
}
