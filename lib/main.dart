import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'pages/home_page.dart';
import 'utils/hex_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary = HexColor.fromHex("#B0FE76");
    Color secondary = HexColor.fromHex("#81E979");
    Color background = HexColor.fromHex("#363635");

    return GetMaterialApp(
      title: 'N2 Mobile - Games',
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: primary,
          primaryContainer: primary.withOpacity(0.85),
          secondary: secondary,
          secondaryContainer: secondary.withOpacity(0.7),
          surface: background,
          error: Colors.redAccent,
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: background,
          titleTextStyle: TextStyle(color: primary, fontSize: 20),
          iconTheme: IconThemeData(color: primary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(150, 50),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondary,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: background,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
