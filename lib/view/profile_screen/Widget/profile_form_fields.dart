import 'package:flutter/material.dart';

class ProfileFormFields extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;

  ProfileFormFields({
    required this.fullNameController,
    required this.usernameController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(fullNameController, 'Ad Soyad', Icons.person),
        SizedBox(height: 16),
        _buildTextField(
            usernameController, 'Kullanıcı Adı', Icons.alternate_email),
        SizedBox(height: 16),
        _buildTextField(emailController, 'Email', Icons.email),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
