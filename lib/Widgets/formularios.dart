import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulariologin/Screens/home.dart';
import 'package:formulariologin/Screens/login.dart';
import 'package:formulariologin/estaticos/estaticos.dart';

import 'package:formulariologin/provider/provider_productos.dart';
import 'package:formulariologin/provider/providerkeylogin.dart';
import 'package:formulariologin/provider/service_login.dart';
import 'package:provider/provider.dart';

class Formularios extends StatelessWidget {
  final String title;
  const Formularios({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ProviderPreoductos>(context);
    return ChangeNotifierProvider(
      create: (context) => PoroviderKey(),
      builder: (context, _) {
        final keyprovider = Provider.of<PoroviderKey>(context, listen: true);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          //color: Colors.red,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
              Form(
                  key: keyprovider.fromkeylogin,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                          onChanged: (value) => keyprovider.email = value,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern);

                            return regExp.hasMatch(value ?? '')
                                ? null
                                : 'incorrecto';
                          },
                          style: const TextStyle(fontSize: 20),
                          autocorrect: false,
                          decoration: Estaticos.inputDecorationCar(
                            icon: Icons.email,
                            label: 'Correo',
                            hint: 'correo@gmail.com',
                          )),
                      TextFormField(
                        onChanged: (value) => keyprovider.pass = value,
                        obscureText: true,
                        autocorrect: false,
                        validator: (value) {
                          return value != null && value.length >= 6
                              ? null
                              : 'debe ser un minimo de 6 letras';
                        },
                        decoration: Estaticos.inputDecorationCar(
                          // icon: Icons.remove_red_eye,
                          label: 'Password',
                          hint: '*******',
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 60),
                        disabledColor: Colors.grey,
                        child: keyprovider.islouding
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator())
                            : Text(
                                title == 'Login' ? 'Entrar' : 'Crear',
                                style: const TextStyle(fontSize: 18),
                              ),
                        color: Colors.indigo,
                        splashColor: Colors.black,
                        elevation: 11,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: keyprovider.islouding
                            ? null
                            : () async {
                                keyprovider.islouding = true;

                                await Future.delayed(
                                    const Duration(seconds: 1));

                                keyprovider.islouding = false;
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                title == 'Login'
                                    ? login(context, data, keyprovider)
                                    : newUser(context, data, keyprovider);
                              },
                      ),
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }

  void login(
      BuildContext context, ProviderPreoductos data, PoroviderKey keyprovider) {
    final providerLogin = Provider.of<ServiceLogin>(context, listen: false);
    FocusScope.of(context).unfocus();
    data.listarproducto.clear();
    data.getProductos();
    if (keyprovider.validar()) {
      providerLogin
          .loginEmailPass(keyprovider.email, keyprovider.pass)
          .then((value) => {
                value
                    ? Navigator.pushReplacementNamed(context, Home.router)
                    : Estaticos.showSnackbar('Usuario Incorrecto')
              });
    } else {
      Estaticos.showSnackbar('Usuario Incorecto');
      null;
    }
  }

  newUser(
      BuildContext context, ProviderPreoductos data, PoroviderKey keyprovider) {
    final autprovider = Provider.of<ServiceLogin>(context, listen: false);
    print('en nuevo usuario ${keyprovider.email} ${keyprovider.pass}  ');
    if (keyprovider.validar()) {
      final resul = autprovider
          .newUser(keyprovider.email, keyprovider.pass)
          .then((value) {
        if (value == 'ok') {
          Estaticos.showSnackbar(value!);
          Navigator.popAndPushNamed(context, Login.router);
        } else {
          Estaticos.showSnackbar(value!);
        }
      });
    } else {
      Estaticos.showSnackbar('Debe completar todos los campos');
    }
  }
}
