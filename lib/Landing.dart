import 'package:bloc_pattern_firebase_tut/Bloc/Auth/auth_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/room_bloc/room_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/root.dart';
import 'package:bloc_pattern_firebase_tut/view/Auth/screens/Login_screen.dart';
import 'package:bloc_pattern_firebase_tut/view/Auth/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBlocBloc, AuthBlocState>(
        builder: (context, state) {
          if (state is AuthInitial || state is AuthLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          } else if (state is AuthAuthenticated) {
            BlocProvider.of<RoomBlocBloc>(context).add(LoadRooms()); //Doğrulandıysa odaları yükle
            return RootScreen();
          } else if (state is AuthOTP) {
            return OTPScreen(
              phoneNumber: state.phoneNumber,
            );
          } else if (state is AuthUnauthenticated) {
            return LoginScreen();
          } else if (state is AuthError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
