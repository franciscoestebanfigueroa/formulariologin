import 'package:flutter/material.dart';
import 'package:formulariologin/estaticos/estaticos.dart';

class WidgetProductos extends StatelessWidget {
  static String router = 'productos';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: const [
              _Foto(),
              _Formulario(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.save_outlined),
        ),
      ),
    );
  }
}

class _Formulario extends StatelessWidget {
  const _Formulario({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      height: MediaQuery.of(context).size.height - 300,
      width: double.infinity,
      child: Form(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              decoration:
                  Estaticos.inputDecorationCar(label: 'Nombre', hint: 'Auto'),
            ),
            TextFormField(
              decoration: Estaticos.inputDecorationCar(
                  label: 'Descripcion', hint: 'Rojo'),
            ),
            TextFormField(
              decoration: Estaticos.inputDecorationCar(
                  label: 'Precio', hint: 'Ejemplo \$ 1000'),
            ),
            const SizedBox(
              height: 20,
            ),
            SwitchListTile.adaptive(
              title: const Text('Disponible'),
              value: false,
              onChanged: (value) {},
            )
          ],
        ),
      ),
    );
  }
}

class _Foto extends StatelessWidget {
  const _Foto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.red,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: const FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage(
                    'https://via.placeholder.com/400x300/f6f6f6f')),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.camera_alt_outlined),
            ),
          )
        ],
      ),
    );
  }
}
