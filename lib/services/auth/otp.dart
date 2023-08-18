import 'package:descope/descope.dart';

Future<void> startOTP(String loginId) async {
  try {
    await Descope.otp.signUp(method: DeliveryMethod.email, loginId: loginId);
    Descope.otp.signIn(method: DeliveryMethod.email, loginId: loginId);
    Descope.otp.signUpOrIn(method: DeliveryMethod.email, loginId: loginId);
  } catch (e) {
    return;
  }
}

Future verifyOTP(String loginId, String code) async {
  // if the user entered the right code the authentication is successful
  final authResponse = await Descope.otp
      .verify(method: DeliveryMethod.email, loginId: loginId, code: code);

// we create a DescopeSession object that represents an authenticated user session
  final session = DescopeSession.fromAuthenticationResponse(authResponse);

// the session manager automatically takes care of persisting the session
// and refreshing it as needed
  Descope.sessionManager.manageSession(session);

  Descope.otp.updatePhone(
      method: DeliveryMethod.email,
      loginId: loginId,
      phone: "phoneNUm",
      refreshJwt: Descope.sessionManager.session!.refreshJwt);
  Descope.otp.updateEmail(
      loginId: loginId,
      email: "email",
      refreshJwt: Descope.sessionManager.session!.refreshJwt);
}
