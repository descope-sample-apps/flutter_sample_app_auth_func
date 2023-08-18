import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:descope/descope.dart';

Future<bool> startOAuth() async {
// todo: Add Flutter_web_auth Android support for OAuth (AndroidManifest.xml changes, etc)

// Choose an oauth provider out of the supported providers
// If configured globally, the redirect URL is optional. If provided however, it will be used
// instead of any global configuration.
  try {
    const options = SignInOptions(customClaims: {"name": "{{user.name}}"});

    final authUrl = await Descope.oauth.start(
        provider: OAuthProvider.google,
        // redirectUrl: "https://api.descope.com/v1/oauth/callback",
        redirectUrl: 'flutter-sample-app://done',
        options: options);

    // Redirect the user to the returned URL to start the OAuth redirect chain
    final result = await FlutterWebAuth.authenticate(
      url: authUrl,
      callbackUrlScheme: 'flutter-sample-app',
    );

    // Extract the returned code
    final code = Uri.parse(result).queryParameters['code'];

    // Exchange code for an authentication response
    final authResponse = await Descope.oauth.exchange(code: code!);
    // we create a DescopeSession object that represents an authenticated user session
    final session = DescopeSession.fromAuthenticationResponse(authResponse);

    // the session manager automatically takes care of persisting the session
    // and refreshing it as needed
    Descope.sessionManager.manageSession(session);
    return true;
  } catch (e) {
    // print(e);
    return false;
  }
}
