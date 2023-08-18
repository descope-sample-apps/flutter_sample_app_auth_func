import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:descope/descope.dart';

Future<String> startSAML() async {
  // Choose which tenant to log into
// If configured globally, the return URL is optional. If provided however, it will be used
// instead of any global configuration.
  final authUrl = await Descope.sso.start(
      emailOrTenantId: 'my-tenant-ID',
      redirectUrl: 'exampleauthschema://my-app.com/handle-saml');
  return authUrl;
}

Future<void> verifySAML(String authUrl) async {
// Redirect the user to the returned URL to start the OAuth redirect chain
  final result = await FlutterWebAuth.authenticate(
      url: authUrl, callbackUrlScheme: 'exampleauthschema');
// Extract the returned code
  final code = Uri.parse(result).queryParameters['code'];
// Exchange code for an authentication response
  final authResponse = await Descope.sso.exchange(code: code!);

  // we create a DescopeSession object that represents an authenticated user session
  final session = DescopeSession.fromAuthenticationResponse(authResponse);

// the session manager automatically takes care of persisting the session
// and refreshing it as needed
  Descope.sessionManager.manageSession(session);
}
