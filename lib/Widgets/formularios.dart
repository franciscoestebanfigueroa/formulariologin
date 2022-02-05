import 'package:flutter/material.dart';
import 'package:formulariologin/estaticos/estaticos.dart';

class Formularios extends StatelessWidget {
  const Formularios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Column(
            children: [
              TextFormField(
                  style: const TextStyle(fontSize: 20),
                  autocorrect: false,
                  decoration: Estaticos.inputDecorationCar(
                    icon: Icons.email,
                    label: 'Correo',
                    hint: 'correo@gmail.com',
                  )),
              TextFormField(
                autocorrect: false,
                decoration: Estaticos.inputDecorationCar(
                  // icon: Icons.remove_red_eye,
                  label: 'Password',
                  hint: '*******',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text('Boton'),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
