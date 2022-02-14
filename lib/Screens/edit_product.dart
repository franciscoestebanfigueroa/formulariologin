import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulariologin/estaticos/estaticos.dart';
import 'package:formulariologin/provider/provider_productos.dart';
import 'package:formulariologin/provider/providerkeyeditpreoduct.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatelessWidget {
  static String router = 'productos';

  const EditProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProviderFormKeyEditProduct()),
      ],
      builder: (BuildContext context, _) {
        final datacopy = Provider.of<ProviderPreoductos>(context);
        print(datacopy.copydata.imagen);
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _Foto(
                    url: datacopy.copydata.imagen,
                  ),
                  const _Formulario(),
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                //  final busqueda = datacopy.listarproducto.indexWhere((element) {
                //    if (element.id == datacopy.copydata.id) {
                //      return true;
                //    } else {
                //      return false;
                //    }
                //  });
                //  datacopy.listarproducto[busqueda] = datacopy.copydata;
                // print(' encontrados ${item}');
                if (datacopy.copydata.id != null) {
                  datacopy.setbasedatos(datacopy.copydata);
                  Navigator.of(context).pop();
                } else {
                  String? pathnube =
                      await datacopy.enviarFoto(datacopy.copydata.imagen!);

                  if (pathnube != null) {
                    datacopy.copydata.imagen = pathnube;
                  }

                  datacopy.nuevoProducto(datacopy.copydata);
                  datacopy.nuevoProductolistalocal(datacopy.copydata);
                  ;
                  Navigator.of(context).pop();
                }
              },
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
    final dataprovider = Provider.of<ProviderPreoductos>(context);
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
              initialValue: dataprovider.copydata.nombre,
              onChanged: (value) {
                dataprovider.copydata.nombre = value.toUpperCase();
              },
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return 'debe escribir una descripcion';
                }
              },
              onChanged: (value) => dataprovider.copydata.descripcion = value,
              initialValue: dataprovider.copydata.descripcion,
              decoration: Estaticos.inputDecorationCar(
                  label: 'Descripcion', hint: 'Rojo'),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              validator: (value) {
                return (value!.isNotEmpty) ? null : 'debe poner precio';
              },
              onChanged: (value) {
                dataprovider.copydata.precio = double.parse(value);
              },
              initialValue: dataprovider.copydata.precio.toString(),
              decoration: Estaticos.inputDecorationCar(
                  label: 'Precio', hint: 'Ejemplo \$ 1000'),
            ),
            const SizedBox(
              height: 20,
            ),
            SwitchListTile.adaptive(
              title: Text(dataprovider.estadoDisponibleCopy
                  ? 'Disponible'
                  : 'No Disponible'),
              value: dataprovider.estadoDisponibleCopy,
              onChanged: (value) {
                dataprovider.estadoDisponibleCopy = value;
              },
            )
          ],
        ),
      ),
    );
  }
}

class _Foto extends StatelessWidget {
  String? url;
  _Foto({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataprovider = Provider.of<ProviderPreoductos>(context);
    return Container(
      height: 300,
      color: Colors.red,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/loading.gif'),
              image: Estaticos.imagenes(dataprovider.copydata.imagen!),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? xfile =
                    await _picker.pickImage(source: ImageSource.camera);
                if (xfile == null) {
                  print('no hay foto');
                } else {
                  print('hay foto name>>${xfile.name} ruta >>${xfile.path}');
                  String path = xfile.path;
                  dataprovider.imagenNueva = path;
                }
              },
              icon: const Icon(Icons.camera_alt_outlined),
            ),
          )
        ],
      ),
    );
  }
}
