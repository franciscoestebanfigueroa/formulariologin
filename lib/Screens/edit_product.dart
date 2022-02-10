import 'package:flutter/material.dart';
import 'package:formulariologin/estaticos/estaticos.dart';
import 'package:formulariologin/provider/provider_productos.dart';
import 'package:formulariologin/provider/providerkeyeditpreoduct.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatelessWidget {
  static String router = 'productos';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProviderFormKeyEditProduct()),
      ],
      builder: (BuildContext context, _) {
        final datacopy = Provider.of<ProviderPreoductos>(context);
        print(datacopy.copydata.id);
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _Foto(
                    url: datacopy.copydata.imagen ?? '',
                  ),
                  const _Formulario(),
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
      },
    );
  }
}

class _Formulario extends StatelessWidget {
  const _Formulario({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = Provider.of<ProviderFormKeyEditProduct>(context);
    //final dataprovider = Provider.of<ProviderPreoductos>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      height: MediaQuery.of(context).size.height - 300,
      width: double.infinity,
      child: Form(
        key: key.fromkeyeditproduct,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return 'ingrese  un nombre';
                }
              },
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
  final String url;
  _Foto({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('URL ${url}');
    return Container(
      height: 300,
      color: Colors.red,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(url == ''
                  ? 'https://via.placeholder.com/400x300/f6f6f6f6'
                  : url),
            ),
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
