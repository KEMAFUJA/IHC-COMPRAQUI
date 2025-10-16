import 'package:flutter/material.dart';
import 'perfil_pantalla.dart';
import 'mis_compras_pantalla.dart';
import 'catalogo_pantalla.dart';
import 'mi_pedido_pantalla.dart';
import 'otros_pantalla.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pantallas = const [
    Perfilpantalla(),
    MisCompraspantalla(),
    Catalogopantalla(),
    MiPedidoPantalla(),
    Otrospantalla(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(['ComprAqui!', 'ComprAqui!', 'ComprAqui!', 'ComprAqui!', 'ComprAqui!'][_selectedIndex]),
      ),
      body: _pantallas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed, // importante si tienes >3 items
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Mis Compras'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Catálogo'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Mi Pedido'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Otros'),
        ],
      ),
    );
  }
}
