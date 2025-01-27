import 'package:bloc_pattern_firebase_tut/Bloc/Auth/auth_bloc_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Center(
              child: Text(
                "Giriş Sayfası",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: "Telefon No",
                border: OutlineInputBorder(),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                final phoneNumber =
                    _phoneNumberController.text.trim(); // Telefon numarasını alıyoruz ve boşlukları temizliyoruz
                if (phoneNumber.isNotEmpty) {
                  // AuthBloc'a LoggedIn event'ini gönderiyoruz.
                  context.read<AuthBlocBloc>().add(LoggedIn(phoneNumber: phoneNumber)); //Giriş trigerini yazıyoruz
                }
              },
              child: Text(
                "Gönder",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
