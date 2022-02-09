import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulariologin/Screens/home.dart';
import 'package:formulariologin/estaticos/estaticos.dart';
import 'package:formulariologin/provider/providerkeylogin.dart';
import 'package:provider/provider.dart';

class Formularios extends StatelessWidget {
  const Formularios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'Formulario',
                style: Theme.of(context).textTheme.headline4,
              ),
              Form(
                  key: keyprovider.fromkeylogin,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
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
                            ? Container(
                                height: 20,
                                width: 20,
                                child: const CircularProgressIndicator())
                            : const Text('Entrar'),
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
                                    const Duration(seconds: 2));

                                keyprovider.islouding = false;
                                await Future.delayed(
                                    const Duration(milliseconds: 200));

                                FocusScope.of(context).unfocus();

                                keyprovider.validar()
                                    ? Navigator.pushReplacementNamed(
                                        context, Home.router)
                                    : Navigator.pushNamed(context, Home.router);
                                //TODO  : null;
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
}
