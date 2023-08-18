import 'package:descope/descope.dart';

Future<void> startPassword(String loginId, String password) async {
  // Every user must have a loginID. All other user information is optional
  final authResponse =
      await Descope.password.signUp(loginId: loginId, password: password);

  // we create a DescopeSession object that represents an authenticated user session
  final session = DescopeSession.fromAuthenticationResponse(authResponse);

// the session manager automatically takes care of persisting the session
// and refreshing it as needed
  Descope.sessionManager.manageSession(session);
}
