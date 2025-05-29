import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'snackbars.dart';

class RegisterService {
  final supabase = Supabase.instance.client;

  Future<void> signUp(String? email, String? password, String? fullName, BuildContext context) async {
    if (email == null || password == null || fullName == null ||
        email.isEmpty || password.isEmpty || fullName.isEmpty) {
      showErrorSnackBar(context, 'Nama Lengkap, Email, dan Password tidak boleh kosong');
      return;
    }

    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      final User? user = res.user;

      if (!context.mounted) return;

      if (user != null) {
        showSuccessSnackBar(context, 'Pendaftaran berhasil! Silakan login untuk melanjutkan.');
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);
      } else {
        showErrorSnackBar(context, 'Pendaftaran gagal. Silakan coba lagi.');
      }

    } on AuthException catch (e) {
      if (e.message.toLowerCase().contains('user already registered')) {
        showErrorSnackBar(context, 'Email ini sudah terdaftar. Silakan login atau gunakan email lain.');
      } else {
        showErrorSnackBar(context, e.message);
      }
    } catch (e) {
      if (context.mounted) showErrorSnackBar(context, 'Terjadi kesalahan: $e');
    }
  }
}
