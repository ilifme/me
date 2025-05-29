import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:me/pages/login_screen.dart';
import 'snackbars.dart';

class LogoutService {
  final supabase = Supabase.instance.client;

  Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } on AuthException catch (e) {
      if (context.mounted)
        showErrorSnackBar(context, 'Logout Gagal: ${e.message}');
    } catch (e) {
      if (context.mounted)
        showErrorSnackBar(context, 'Logout Gagal: Terjadi kesalahan.');
    }
  }
}
