import 'package:flutter/material.dart';
import 'package:formulariologin/Screens/screens.dart';
import 'package:formulariologin/provider/provider_productos.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static String router = 'home';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Productos'),
        ),
        body: ChangeNotifierProvider(
            create: (context) => ProviderPreoductos(),
            child: ListCardProductos()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            ProviderPreoductos();
          },
        ),
      ),
    );
  }
}

class ListCardProductos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataprovider = Provider.of<ProviderPreoductos>(context);
    return ListView.builder(
      itemCount: dataprovider.listarproducto.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: _boxdecorationcard(),
            width: 400,
            height: 300,
            child: CardCustom(
              disponible: dataprovider.listarproducto[index].disponible,
              nombre: dataprovider.listarproducto[index].nombre,
              descripcion: dataprovider.listarproducto[index].descripcion ?? '',
              precio: dataprovider.listarproducto[index].precio,
              netimagen: dataprovider.listarproducto[index].imagen,
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _boxdecorationcard() => BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      );
}

class CardCustom extends StatelessWidget {
  final bool disponible;
  final String nombre;
  final double precio;
  final String descripcion;
  final String? netimagen;
  const CardCustom({
    Key? key,
    required this.disponible,
    required this.nombre,
    required this.precio,
    required this.descripcion,
    this.netimagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, WidgetProductos.router);
          },
          child: SizedBox(
            //color: Colors.red,
            width: 400,
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(netimagen == null
                    ? 'https://via.placeholder.com/400x300/f6f6f6f6'
                    : netimagen!),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                '\$ ${precio.toString()}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            width: 100,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            disponible ? 'DISPONIBLE' : 'SIN STOCK',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          width: 120,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: disponible ? Colors.amber[900] : Colors.red,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre.toUpperCase(),
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    descripcion,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            width: 270,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
          ),
        )
      ],
    );
  }
}
