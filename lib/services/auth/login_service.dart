import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:me/pages/home_screen.dart';
import 'snackbars.dart';

class LoginService {
  final supabase = Supabase.instance.client;

  Future<void> login(String? email, String? password, BuildContext context) async {
    if (email == null || password == null || email.isEmpty || password.isEmpty) {
      showErrorSnackBar(context, 'Email dan password tidak boleh kosong');
      return;
    }

    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final User? user = res.user;

      if (user != null && context.mounted) {
        showSuccessSnackBar(context, 'Login berhasil');

        await Future.delayed(const Duration(milliseconds: 500));

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
        );
      } else if (context.mounted) {
        showErrorSnackBar(context, 'Email atau password salah, atau email belum dikonfirmasi.');
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        final errorMessage = e.message.toLowerCase().contains('invalid login credentials')
            ? 'Email atau password salah'
            : e.message;
        showErrorSnackBar(context, errorMessage);
      }
    } catch (e) {
      if (context.mounted) showErrorSnackBar(context, 'Terjadi kesalahan: $e');
    }
  }
}
