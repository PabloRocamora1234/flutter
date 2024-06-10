
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejemplo_login/screens/home_screens.dart';
import 'package:flutter_application_1/ejemplo_login/screens/inputs_screen.dart';
import 'package:flutter_application_1/ejemplo_login/screens/settings_screen.dart';
import 'package:flutter_application_1/ejemplo_login/shared_preferences/preferencias.dart';
import 'package:flutter_application_1/ejemplo_login/temas/app_tema.dart';

//void main() => runApp(MyApp());
//Las preferencias las cargo en el main, ya que este sí puede ser asíncrono,
// mientras que dentro de build no puedo cargarlo, ya que build es síncrono

void main() async{

  /*
  * Antes de que una aplicación Flutter pueda ejecutar su código, es necesario que los enlaces de Flutter estén inicializados. Esto implica la configuración de la infraestructura necesaria para que Flutter funcione, incluyendo la comunicación con el motor gráfico subyacente.*/
  WidgetsFlutterBinding.ensureInitialized();
  //llamo la inicialización de preferences
  await Preferences.init();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  /** Key es un identificador único para un widget. Especificar una clave (key)
   *  puede ser útil cuando necesitas identificar un widget de manera única.
   */
  const MyApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: InputScreen.routerName,
      routes: {
        HomeScreen.routerName: ( _ ) => const HomeScreen(),
        SettingScreen.routerName: ( _ ) => const SettingScreen(),
        InputScreen.routerName: ( _ ) => const InputScreen(),
      },
      theme: AppTema.lightTheme,
    );
  }
}