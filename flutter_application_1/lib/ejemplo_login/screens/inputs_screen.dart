import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  static const String routerName = "Inputs";
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FORMULARIO"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                TextFormField(
                  autofocus: false,
                  initialValue: "usuario",
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: ( value ){
                    print(value);
                  },
                  validator: ( value ){
                    if( value == null) return "Este campo es obligatorio";
                    return value.length < 6 ? 'Mínimo de caracteres 6 ' : null;

                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: "Nombre del usuario",
                    labelText: "Usuario",
                    helperText: "Sólo letras",
                    suffixIcon: Icon(Icons.group_outlined),
                    prefixIcon: Icon(Icons.verified_outlined),
                    icon: Icon(Icons.admin_panel_settings),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide( color: Colors.brown),
                        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10) )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green
                      )
                    ),
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(30))
                    )
                  ),
                )

              ],
            ),
          ),
        )
      ),
    );
  }
}