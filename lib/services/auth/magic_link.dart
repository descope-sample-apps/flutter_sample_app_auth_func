import 'package:descope/descope.dart';

Future startMagicLink() async {
  
  print('start auth');
  SignInOptions options = SignInOptions(customClaims: Map<String, dynamic>.from({'name': 'allen'}));
  
  String phone = '+18173740750';
  final link = await Descope.magicLink.signUpOrIn(method: DeliveryMethod.sms, loginId: phone,
   redirectUrl: 'https://thewatercooler.app/magiclink', 
   options: options);
  print(link);
  
  print('got auth response');
  
  return true;

}

Future verifyMagicLink(String token) async {

  final authResponse = await Descope.magicLink.verify(token: token);
  final session = DescopeSession.fromAuthenticationResponse(authResponse);
  Descope.sessionManager.manageSession(session);

  print(session.sessionJwt);
  print(session.refreshJwt);
  
  Descope.sessionManager.refreshSessionIfNeeded();
  
  return authResponse;
}
