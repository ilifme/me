import 'package:flutter/material.dart';
import 'package:me/pages/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vlzhvhubzsocgirqwsqd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZsemh2aHVienNvY2dpcnF3c3FkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg0OTE0MTgsImV4cCI6MjA2NDA2NzQxOH0.C_oqgDu_JWoSd3LerjmiefVr6aqIBZ2DCBe0R2IXddw',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ourecycle',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,),
      ),
      home: LoginScreen(),
    );
  }
}