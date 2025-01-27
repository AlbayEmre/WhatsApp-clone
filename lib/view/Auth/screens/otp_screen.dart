import 'package:bloc_pattern_firebase_tut/Bloc/Auth/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPScreen extends StatelessWidget {
  final String phoneNumber;
  OTPScreen({super.key, required this.phoneNumber});

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Center(
              child: Text(
                "Doğrulama Sayfası",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: "Kodu Giriniz",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {
                final otp = _otpController.text.trim(); // OTP'yi alıyoruz ve boşlukları temizliyoruz
                if (otp.isNotEmpty) {
                  // AuthBloc'a VerifyOtp event'ini gönderiyoruz.
                  context
                      .read<AuthBlocBloc>()
                      .add(VerifyOtp(phoneNumber: phoneNumber, otp: otp)); //doğrulamayı yapıyoruz
                }
              },
              child: const Text(
                "Doğrula",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
