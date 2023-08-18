import 'package:descope/descope.dart';

Future<void> startTOTP(String loginId) async {
  try {
    final totpResponse = await Descope.totp.signUp(loginId: loginId);
    Descope.totp.update(
        loginId: loginId,
        refreshJwt: Descope.sessionManager.session!.refreshJwt);

    // Use one of the provided options to have the user add their credentials to the authenticator
    // totpResponse.provisioningUrl
    totpResponse.image;
    // totpResponse.key
  } catch (e) {
    return;
  }
}

Future verifyTOTP(String loginId, String code) async {
  // if the user entered the right code the authentication is successful
  final authResponse = await Descope.totp.verify(loginId: loginId, code: code);

// we create a DescopeSession object that represents an authenticated user session
  final session = DescopeSession.fromAuthenticationResponse(authResponse);

// the session manager automatically takes care of persisting the session
// and refreshing it as needed
  Descope.sessionManager.manageSession(session);
}
