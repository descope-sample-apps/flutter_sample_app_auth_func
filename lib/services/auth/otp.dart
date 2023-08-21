import 'package:descope/descope.dart';

Future<bool> startOTP(String loginId) async {
  try {
    Descope.otp.signUpOrIn(method: DeliveryMethod.email, loginId: loginId);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> verifyOTP(String loginId, String code) async {
  try {
    // if the user entered the right code the authentication is successful
    final authResponse = await Descope.otp
        .verify(method: DeliveryMethod.email, loginId: loginId, code: code);
// we create a DescopeSession object that represents an authenticated user session
    final session = DescopeSession.fromAuthenticationResponse(authResponse);
// the session manager automatically takes care of persisting the session
// and refreshing it as needed
    Descope.sessionManager.manageSession(session);
    return true;
  } catch (e) {
    return false;
  }
}
