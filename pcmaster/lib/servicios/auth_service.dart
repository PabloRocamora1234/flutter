import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // iniciar proceso interactivo sign in
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        // El usuario canceló el inicio de sesión
        return null;
      }

      // obtener detalles auth de la request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // crear credencial al usuario
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // finalmente sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print("Error al autenticar: ${e.message}");
      return null;
    } catch (e) {
      print("Error inesperado: $e");
      return null;
    }
  }
}
