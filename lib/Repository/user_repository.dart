import 'package:bloc_pattern_firebase_tut/Models/User_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Bu repo ile fire base ile iletişim sağlar
class UserRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection("users");

  Future<void> addUser({required UserModel user}) {
    return collection
        .doc(user.userId)
        .set(user.toJson()); //kulanıcı ekle firebase noSql oldundan json tiğidne olması gerek
  }

  //Kulanıcının kedisini günceler ve geri dönderir
  Future<void> updateUser(UserModel user) {
    return collection.doc(user.userId).update(user.toJson()).then((_) => print("User Updated")).catchError((error) {
      print("Failed to update user:$error");
    });
  }

  Future<void> updateUserPicture(String userId, String userPicture) {
    return collection
        .doc(userId)
        .update({"userPicture": userPicture})
        .then((_) => print("User Picture Updated"))
        .catchError((error) => print("Falied to update user picture:$error"));
  }

  Future<void> updateUserProfile(String userId, String fullName, String username, String userEmail) async {
    return collection
        .doc(userId)
        .update({"fullName": fullName, "userName": username, "userEmail": userEmail})
        .then((value) => print("User Profile Updated"))
        .catchError((error) => print("Falied to update user profile$error"));
  }

  Future<UserModel?> getUser(String id) async {
    DocumentSnapshot doc = await collection.doc(id).get();
    if (doc.exists) //eyer doc  mevcut ise
    {
      return UserModel.fromSnapshot(doc);
    }
    return null;
  }

//Tüm kullanıcıları getirir
  Stream<List<UserModel>> getUsers() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    });
  }
}
