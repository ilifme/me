import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import 'package:me/pages/setting_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  int points = 169;

  void _onNavTapped(int index) {
    if (index == 3) {
      // Arahkan ke halaman Setting saat tab Setting diklik
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingScreen()),
      );
    } else {
      // Untuk tab lain, update tampilan sesuai index
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          'OuRecycle',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/aku.png'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Hi, Drupadi 👋',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Let\'s save the environment today!',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),

          const SizedBox(height: 24),

          // OurPoints Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.green, Colors.blue]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.white, size: 32),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'OurPoints',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      '$points pts',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Gold 🏆',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Quick Action Menu
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _menuItem(Icons.info, 'Info', Colors.green.shade100),
              _menuItem(Icons.store, 'Store', Colors.blue.shade100),
              _menuItem(Icons.local_shipping, 'Drop Off', Colors.blue.shade100),
              _menuItem(Icons.motorcycle, 'Pick Up', Colors.green.shade100),
            ],
          ),

          const SizedBox(height: 24),

          // Banner or news section
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/images/banner.png'),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavbar(
        currentIndex: currentIndex,
        onTap: _onNavTapped,
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Aksi menu bisa ditambahkan di sini
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.black54),
            const SizedBox(height: 8),
            Text(label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                )),
          ],
        ),
      ),
    );
  }
}
