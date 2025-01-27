import 'package:bloc_pattern_firebase_tut/Bloc/room_bloc/room_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Models/Room_model.dart';
import 'package:bloc_pattern_firebase_tut/controller/User_uid_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Flutter'ın temel widget paketini içe aktarıyoruz.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class RoomForm extends StatefulWidget {
  final RoomModel? room; // Düzenleme işlemi için mevcut oda.

  RoomForm({this.room});

  @override
  _RoomFormState createState() => _RoomFormState();
}

class _RoomFormState extends State<RoomForm> {
  final _formKey = GlobalKey<FormState>(); // Form anahtarı.
  String? _name; // Oda adı.
  String? _description; // Oda açıklaması.
  String userUid = GetUserInformation.getUserUid();

  @override
  void initState() {
    super.initState();
    if (widget.room != null) {
      _name = widget.room!.roomName; // Oda adı.
      _description = widget.room!.roomDescription; // Oda açıklaması.
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var uuid = Uuid(); // Uuid örneği oluşturuyoruz.
      final roomId = widget.room?.roomId ?? uuid.v4(); // Mevcut oda varsa roomId'yi kullan, yoksa yeni bir ID oluştur.

      final room = RoomModel(
        adminUsers: [userUid],
        atCreate:
            widget.room?.atCreate ?? Timestamp.now(), // Eğer oda güncelleniyorsa mevcut oluşturulma zamanını kullan,
        atSubscriptionPriceUpdate: Timestamp.now(),
        atUpdate: Timestamp.now(), // Güncelleme zamanı
        bannedUsers: [],
        creatorUser: userUid,
        isActive: true,
        participantUsers: [userUid],
        roomCoverImage: "",
        roomDescription: _description!,
        roomId: roomId,
        roomImage: "",
        roomName: _name!,
        roomTitle: "",
        //subscriptionPrice: 0,
      );

      /*final room = RoomModel(
        adminUsers: [],
        bannedUsers: [],
        createdAt: widget.room?.createdAt ??
            Timestamp
                .now(), // Eğer oda güncelleniyorsa mevcut oluşturulma zamanını kullan
        creatorUser: userUid,
        isActive: true,
        participantUsers: [],
        roomCoverImage: "",
        roomDescription: _description!,
        roomId: roomId,
        roomImage: "",
        roomName: _name!,
        roomTitle: "",
        subscriptionPrice: 0.0,
        subscriptionPriceUpdatedAt: Timestamp.now(),
        updatedAt: Timestamp.now(), // Güncelleme zamanı
      );*/

      if (widget.room == null) {
        BlocProvider.of<RoomBlocBloc>(context).add(AddRoom(room)); // Yeni oda ekleme olayı.
      } else {
        BlocProvider.of<RoomBlocBloc>(context).add(UpdateRoom(room)); // Oda güncelleme olayı.
      }
      Navigator.of(context).pop(); // Form kapatma.
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.room == null ? 'Oda Oluştur' : 'Oda Düzenle'), // Form başlığı.
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Oda Adı'), // Oda adı alanı.
              validator: (value) => value!.isEmpty ? 'Please enter a name' : null, // Doğrulama.
              onSaved: (value) => _name = value, // Kaydetme.
            ),
            TextFormField(
              initialValue: _description,
              decoration: InputDecoration(labelText: 'Konu'), // Oda açıklaması alanı.
              validator: (value) => value!.isEmpty ? 'Please enter a description' : null, // Doğrulama.
              onSaved: (value) => _description = value, // Kaydetme.
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Kaydet'),
              onPressed: _submit, // Formu gönderme.
            ),
          ],
        ),
      ),
    );
  }
}
