import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../paleta.dart';
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

// Esta es la clase que maneja el estado del HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Índice de la pantalla actualmente seleccionada
  late PageController
  _pageController; // Controlador para navegar entre páginas (PageView)

  // Lista de las pantallas que se muestran en el PageView
  final List<Widget> _pantallas = const [
    Perfilpantalla(),
    MisCompraspantalla(),
    Catalogopantalla(),
    MiPedidoPantalla(),
    Otrospantalla(),
  ];

  // Inicializa el PageController al crear el estado
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  // Libera los recursos del PageController cuando se destruye el widget
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Esta función se llama cuando el usuario toca un ítem del BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Actualiza el índice de pantalla seleccionado
      // Anima la transición al nuevo índice de página
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tema global usando Provider
    final theme = Provider.of<AppTheme>(context);

    return Scaffold(
      appBar: AppBar(
        // Titulo fijo para todoas las pestañas
        title: Text('ComprAqui!'),
        backgroundColor: theme.primaryColor, // Color principal global
      ),
      body: PageView.builder(
        controller: _pageController, // Controla la página visible
        physics: const ClampingScrollPhysics(), // Evita el rebote al deslizar
        onPageChanged: (index) {
          // Cuando el usuario desliza manualmente, actualiza el índice
          setState(() {
            _selectedIndex = index;
          });
        },
        itemCount: _pantallas.length, // Número de páginas
        itemBuilder: (context, index) {
          // Aplicamos animación de fade + slide al cambiar de página
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                // Calcula la diferencia de página actual vs índice
                value =
                    ((_pageController.page ?? _selectedIndex.toDouble()) -
                    index.toDouble());
                // Limita el valor de escala para el efecto
                value = (1 - (value.abs() * 0.3)).clamp(0.8, 1.0);
              }

              return Opacity(
                opacity: value, // Ajusta la opacidad según la escala
                child: Transform.translate(
                  offset: Offset(
                    50 * (1 - value),
                    0,
                  ), // Efecto de deslizamiento
                  child: child,
                ),
              );
            },
            child: _pantallas[index], // Muestra la pantalla correspondiente
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Resalta el ítem seleccionado
        type: BottomNavigationBarType.fixed, // Muestra todos los ítems fijos
        onTap: _onItemTapped, // Llama a la función cuando se toca un ítem
        selectedItemColor: theme.primaryColor, // Color de ítem seleccionado
        unselectedItemColor:
            theme.textColorSecon, // Color de ítem no seleccionado
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Mis Compras',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Catálogo'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Mi Pedido'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Otros'),
        ],
      ),
    );
  }
}
