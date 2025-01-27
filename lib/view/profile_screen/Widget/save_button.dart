import 'package:bloc_pattern_firebase_tut/Bloc/User_bloc/user_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//kULLANICI PROFİLİNİ GÜNCELLE
class SaveButton extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;

  SaveButton({
    required this.fullNameController,
    required this.usernameController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<UserBlocBloc>().add(
              UpdateUserProfile(
                fullName: fullNameController.text,
                userName: usernameController.text,
                userEmail: emailController.text,
              ),
            );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Kaydet',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
