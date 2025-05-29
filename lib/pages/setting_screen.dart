import 'package:flutter/material.dart';
import 'package:me/services/auth/logout_service.dart';
// import 'package:me/pages/change_password_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isDarkMode = false; // Contoh state untuk tema
  final LogoutService _logoutService = LogoutService();

  // Fungsi untuk menampilkan dialog konfirmasi logout
  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Pengguna harus menekan tombol
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin keluar dari akun ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
                _logoutService.logout(context); // Lakukan logout
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk navigasi ke ganti password
  void _navigateToChangePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigasi ke Halaman Ganti Password...')),
    );
    // TODO: Buat ChangePasswordScreen dan uncomment navigasi di bawah
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.white, // Sesuaikan warna
        foregroundColor: Colors.black, // Sesuaikan warna
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          _buildSettingsSection(
            title: 'Akun',
            children: [
              _buildSettingsTile(
                icon: Icons.lock_outline,
                title: 'Ganti Password',
                onTap: _navigateToChangePassword,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSettingsSection(
            title: 'Tampilan',
            children: [
              ListTile(
                leading: Icon(Icons.brightness_6_outlined, color: Colors.grey.shade700),
                title: const Text('Mode Gelap'),
                trailing: Switch(
                  value: _isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      _isDarkMode = value;
                      // TODO: Implementasikan logika penggantian tema
                      // Anda mungkin perlu menggunakan state management (Provider, Riverpod, etc.)
                      // dan memanggil fungsi untuk mengubah tema aplikasi.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mode Gelap ${value ? 'Aktif' : 'Nonaktif'} (Implementasi diperlukan)')),
                      );
                    });
                  },
                  activeColor: Colors.green,
                ),
                tileColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSettingsSection(
            title: 'Lainnya',
            children: [
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () => _showLogoutDialog(context),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder( // Hanya untuk contoh, bisa dihapus
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  // Helper untuk membuat grup pengaturan
  Widget _buildSettingsSection({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          ListView( // Gunakan ListView agar bisa ada divider
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          ),
        ],
      ),
    );
  }


  // Helper untuk membuat item pengaturan standar
  Widget _buildSettingsTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      tileColor: Colors.white,
    );
  }
}