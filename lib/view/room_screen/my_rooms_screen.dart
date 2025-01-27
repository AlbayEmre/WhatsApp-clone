import 'package:bloc_pattern_firebase_tut/Bloc/room_user_bloc/room_user_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/room_user_bloc/room_user_event.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/room_user_bloc/room_user_state.dart';
import 'package:bloc_pattern_firebase_tut/controller/User_uid_controller.dart';
import 'package:bloc_pattern_firebase_tut/view/room_screen/room_form.dart';
import 'package:bloc_pattern_firebase_tut/view/room_screen/widget/room_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Kullanıcının oluşturduğu odaları gösteren ekran sınıfı.
class MyRoomsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userUid = GetUserInformation.getUserUid();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Odalarım",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocBuilder<RoomUserBloc, RoomUserState>(
        builder: (context, state) {
          if (state is RoomUserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RoomUserLoaded) {
            return ListView.builder(
              itemCount: state.rooms.length,
              itemBuilder: (context, index) {
                final room = state.rooms[index];
                return RoomCard(
                  room: room,
                  onEdit: () {
                    showDialog(
                      context: context,
                      builder: (_) => RoomForm(room: room),
                    );
                  },
                  onDelete: () {
                    BlocProvider.of<RoomUserBloc>(context).add(
                      DeleteUserRoom(room.roomId, userUid),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Oluşturulmuş Oda Yok'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => RoomForm(),
          );
        },
      ),
    );
  }
}
