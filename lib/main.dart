import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahram_optimise_v01/screens/MyAnimatedWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'Ma7ram',
      theme: ThemeData().copyWith(
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(
            0xFF79747E,
            <int, Color>{
              50: Color(0xFFEAE9EB),
              100: Color(0xFFCBC7CE),
              200: Color(0xFFACA5B1),
              300: Color(0xFF8C8294),
              400: Color(0xFF7A7881),
              500: Color(0xFF79747E),
              600: Color(0xFF736E79),
              700: Color(0xFF6B676F),
              800: Color(0xFF645E65),
              900: Color(0xFF554E56),
            },
          ),
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return const MyAnimatedWidget();
        },
      ),
    );
  }
}
