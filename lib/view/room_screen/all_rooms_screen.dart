import 'package:bloc_pattern_firebase_tut/Bloc/room_bloc/room_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/view/room_screen/widget/room_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllRoomsScreen extends StatelessWidget {
  const AllRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Keşfet",
          style: TextStyle(fontWeight: FontWeight.w900),
        ), // Uygulama başlığı "Keşfet"
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocBuilder<RoomBlocBloc, RoomBlocState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return Center(child: CircularProgressIndicator()); // Yükleme durumu.
          } else if (state is RoomLoaded) {
            // Oda verileri yüklendiğinde.
            return Padding(
              padding: EdgeInsets.all(7.0),
              child: ListView.builder(
                itemCount: state.roomss.length, // Oda sayısı.
                itemBuilder: (context, index) {
                  final room = state.roomss[index]; // Her bir oda.
                  return RoomListTile(
                    room: room,
                    onJoinPressed: () {
                      // Katıl butonuna basıldığında yapılacak işlemler
                    },
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('Odalar yüklenemedi')); // Hata durumu.
          }
        },
      ),
    );
  }
}
