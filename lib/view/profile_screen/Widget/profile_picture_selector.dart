import 'package:bloc_pattern_firebase_tut/Bloc/User_bloc/user_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/view/profile_screen/Widget/emoji_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePictureSelector extends StatelessWidget {
  final String userPicture;

  ProfilePictureSelector({
    required this.userPicture,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // Daha sıkı ve estetik bir görünüm için
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: faceEmojis.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      String selectedEmoji = faceEmojis[index];
                      context.read<UserBlocBloc>().add(UpdateUserProfiePisture(selectedEmoji));
                      Navigator.pop(context); // BottomSheet'i kapat
                    },
                    child: Center(
                      child: Text(
                        faceEmojis[index],
                        style: TextStyle(fontSize: 28), // Daha büyük ve dikkat çekici
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.grey[200],
        child: Text(
          userPicture,
          style: const TextStyle(fontSize: 105), // Profil fotoğrafını daha belirgin yap
        ),
      ),
    );
  }
}
