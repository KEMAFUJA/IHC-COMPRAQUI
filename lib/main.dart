import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/tema.dart';
import 'paleta.dart';

// Providers
import 'providers/usuario.dart';
import 'providers/compras.dart';
import 'providers/productos.dart';
import 'providers/resenas.dart';
import 'providers/carrito.dart';
import 'providers/pedidos.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usuario()),
        ChangeNotifierProvider(create: (_) => Compras()),
        ChangeNotifierProvider(create: (_) => Productos()),
        ChangeNotifierProvider(create: (_) => Resenas()),
        ChangeNotifierProvider(create: (_) => Carrito()),
        ChangeNotifierProvider(create: (_) => Tema()),
        ChangeNotifierProvider(create: (_) => AppTheme()),
        ChangeNotifierProvider(create: (_) => Pedidos()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Provider.of<Tema>(context);
    final appTheme = Provider.of<AppTheme>(context);

    return MaterialApp(
      title: 'ComprAqui!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: appTheme.primaryColor,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: appTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: appTheme.primaryColor,
          unselectedItemColor: Colors.grey,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
          headlineMedium: const TextStyle(
            fontSize: 30, // títulos medianos
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleLarge: const TextStyle(
            fontSize: 20, // subtítulos medianos
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          bodyMedium: const TextStyle(
            fontSize: 15, // cuerpo más pequeño
            color: Colors.black87,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: appTheme.primaryColor,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: appTheme.primaryColor,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          selectedItemColor: appTheme.primaryColor,
          unselectedItemColor: appTheme.textColorSecon,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
          headlineMedium: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey,
          ),
          bodyMedium: const TextStyle(fontSize: 15, color: Colors.blueGrey),
        ),
      ),
      themeMode: tema.themeMode,
      home: const HomeScreen(),
    );
  }
}
