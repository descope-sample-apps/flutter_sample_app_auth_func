import 'package:descope/descope.dart';

Future<void> logout() async {
  final refreshJwt = Descope.sessionManager.session?.refreshJwt;
  if (refreshJwt != null) {
    await Descope.auth.logout(refreshJwt);
    Descope.sessionManager.clearSession();
  }
}
