import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormularioPage(),
    );
  }
}

class FormularioPage extends StatefulWidget {
  const FormularioPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormularioPageState();
  }
}

class _FormularioPageState extends State<FormularioPage> {
  String _nombre = "";
  String _email = "";
  String _password = "";
  int _valorEscogido = 1;
  bool _checkValor = false;
  bool _switchValor = false;
  String _radioValor = "";
  Set<String> _valoresRadio = {"B2", "B1", "C2", "A2"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario"),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200], // Cambia el color de fondo según tus preferencias
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              _crearInput(),
              Divider(),
              _crearEmail(),
              Divider(),
              _crearPassword(),
              Divider(),
              _crearCheckbox(),
              Divider(),
              _crearDropDown(),
              Divider(),
              _crearRadio(),
              Divider(),
              _visualizarDatos(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _visualizarDatos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("NOMBRE: $_nombre"),
        Text("EMAIL: $_email"),
        Text("PASSWORD: $_password"),
        Text("LISTA: $_valorEscogido"),
        Text("CARNET: $_checkValor"),
      ],
    );
  }

  Widget _crearRadio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _elemsRadio(),
    );
  }

  List<Widget> _elemsRadio() {
    List<Widget> lista = [];
    _valoresRadio.forEach((element) {
      RadioListTile r = RadioListTile(
        title: Text(element),
        value: element,
        groupValue: _radioValor,
        onChanged: (valor) {
          setState(() {
            _radioValor = valor;
          });
        },
      );
      lista.add(r);
    });
    return lista;
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      value: _switchValor,
      onChanged: (valor) {
        setState(() {
          _switchValor = valor;
        });
      },
      secondary: Icon(Icons.lightbulb_outline),
    );
  }

  Widget _crearInput() {
    return TextField(
      onChanged: (valor) => setState(() {
        _nombre = valor;
      }),
      textCapitalization: TextCapitalization.words,
      maxLength: 30,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: "Introduce un nombre",
        labelText: "Nombre",
        suffixIcon: Icon(Icons.person),
        icon: Icon(Icons.person),
      ),
    );
  }

  Widget _crearEmail() {
    return TextField(
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: "Introduce el email",
        labelText: "Email",
        suffixIcon: Icon(Icons.email),
        icon: Icon(Icons.email),
      ),
    );
  }

  Widget _crearPassword() {
    return TextField(
      onChanged: (valor) => setState(() {
        _password = valor;
      }),
      obscureText: true,
      obscuringCharacter: '*',
      maxLength: 15,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: "Introduce la contraseña",
        labelText: "Password",
        suffixIcon: Icon(Icons.lock),
        icon: Icon(Icons.lock),
      ),
    );
  }

  Widget _crearDropDown() {
    return DropdownButton(
      value: _valorEscogido,
      onChanged: (int? valor) {
        setState(() {
          _valorEscogido = valor ?? 1;
        });
      },
      items: [
        DropdownMenuItem(child: Text("OPCIÓN 1"), value: 1),
        DropdownMenuItem(child: Text("OPCIÓN 2"), value: 2),
        DropdownMenuItem(child: Text("OPCIÓN 3"), value: 3),
        DropdownMenuItem(child: Text("OPCIÓN 4"), value: 4),
      ],
      icon: Icon(Icons.arrow_drop_down),
    );
  }

  Widget _crearCheckbox() {
    return CheckboxListTile(
      title: Text("CARNET CONDUCIR"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.orangeAccent),
      ),
      value: _checkValor,
      onChanged: (nuevoValor) {
        setState(() {
          _checkValor = nuevoValor!;
        });
      },
      secondary: Icon(Icons.directions_car),
    );
  }
}
