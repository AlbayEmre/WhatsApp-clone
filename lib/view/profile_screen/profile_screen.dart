import 'package:bloc_pattern_firebase_tut/Bloc/Auth/auth_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/User_bloc/user_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/view/profile_screen/Widget/profile_form_fields.dart';
import 'package:bloc_pattern_firebase_tut/view/profile_screen/Widget/profile_picture_selector.dart';
import 'package:bloc_pattern_firebase_tut/view/profile_screen/Widget/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<AuthBlocBloc>().add(LoggedOut()); //Çıkış yapmak için buton
            },
          ),
        ],
      ),
      body: BlocConsumer(
        listener: (context, state) {
          if (state is UserProfilePictureUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profil fotoğrafı güncellendi!"),
              ),
            );
          } else if (state is UserProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profil bilgileri güncellendi!"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const CircularProgressIndicator();
          }
          if (state is UserLoaded) {
            final user = state.user;

            final fullNameConttroller = TextEditingController(text: user.fullName);
            final usernameConttroller = TextEditingController(text: user.userName);
            final emailConttroller = TextEditingController(text: user.userEmail);

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePictureSelector(userPicture: user.userPicture),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Ruh Halin Nasıl Hemen Belirle!",
                    style: TextStyle(
                        fontSize: 17, color: Colors.blueGrey, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 32),
                  ProfileFormFields(
                    fullNameController: fullNameConttroller,
                    usernameController: usernameConttroller,
                    emailController: emailConttroller,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SaveButton(
                    fullNameController: fullNameConttroller,
                    usernameController: usernameConttroller,
                    emailController: emailConttroller,
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('Kullanıcı bilgileri yüklenemedi.'),
          );
        },
      ),
    );
  }
}
