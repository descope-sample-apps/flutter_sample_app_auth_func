import 'package:descope/descope.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> startFlow() async {
  final String projectId = dotenv.env['DESCOPE_PROJECT_ID']!;

  String? flowUrl = dotenv.env['DESCOPE_FLOW_URL'];
  if (flowUrl == null || flowUrl.isEmpty) {
    flowUrl = 'https://auth.descope.io/$projectId';
  }
  final deepLinkUrl = dotenv.env['DESCOPE_DEEP_LINK_URL'];

  try {
    final authResponse =
        await Descope.flow.start(flowUrl, deepLinkUrl: deepLinkUrl);
    final session = DescopeSession.fromAuthenticationResponse(authResponse);
    Descope.sessionManager.manageSession(session);
    return true;
  } catch (e) {
    print('ERROR: $e');
    return false;
  }
}

Future<void> logout() async {
  final refreshJwt = Descope.sessionManager.session?.refreshJwt;
  if (refreshJwt != null) {
    await Descope.auth.logout(refreshJwt);
    Descope.sessionManager.clearSession();
  }
}
