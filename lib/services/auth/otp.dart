import 'package:descope/descope.dart';

Future<bool> startOTP(String loginId) async {
  try {

    Map<String, dynamic> customClaims = Map<String, dynamic>.from({'name': 'allen'});
    SignInOptions options = SignInOptions(customClaims: customClaims);
    Descope.otp.signUpOrIn(method: DeliveryMethod.sms, loginId: loginId, options: options);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> verifyOTP(String loginId, String code) async {
  try {
    print('verifying otp');

    // if the user entered the right code the authentication is successful
    final authResponse = await Descope.otp
        .verify(method: DeliveryMethod.sms, loginId: loginId, code: code);
// we create a DescopeSession object that represents an authenticated user session
    final session = DescopeSession.fromAuthenticationResponse(authResponse);
    // the session manager automatically takes care of persisting the session
    // and refreshing it as needed
    print(session.sessionJwt);
    print('Refresh token');
    print(session.refreshJwt);
    Descope.sessionManager.manageSession(session);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
