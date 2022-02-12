import 'package:flutter/material.dart';
import 'package:formulariologin/Screens/screens.dart';
import 'package:formulariologin/model/producto.dart';
import 'package:formulariologin/provider/provider_productos.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static String router = 'home';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ProviderPreoductos>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Productos'),
        ),
        body: const ListCardProductos(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final Producto nuevo = Producto(
              nombre: '',
              descripcion: '',
              disponible: false,
              precio: 0.0,
            );
            dataProvider.copydata = nuevo.copy();
            Navigator.pushNamed(context, EditProduct.router);

            // dataProvider.nuevoProducto(nuevo);
          },
        ),
      ),
    );
  }
}

class ListCardProductos extends StatelessWidget {
  const ListCardProductos({Key? key}) : super(key: key);

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
              producto: dataprovider.listarproducto[index],
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
  final Producto producto;
  const CardCustom({
    required this.producto,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataprovider = Provider.of<ProviderPreoductos>(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // print(producto.id);
            dataprovider.copydata = producto.copy();

            Navigator.pushNamed(context, EditProduct.router);
          },
          child: SizedBox(
            width: 400,
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(producto.imagen == null
                    ? 'https://via.placeholder.com/400x300/f6f6f6f6'
                    : producto.imagen!),
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
                '\$ ${producto.precio.toString()}',
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
            producto.disponible ? 'DISPONIBLE' : 'SIN STOCK',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          width: 120,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: producto.disponible ? Colors.amber[900] : Colors.red,
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
                    producto.nombre.toUpperCase(),
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    producto.descripcion ?? '',
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
