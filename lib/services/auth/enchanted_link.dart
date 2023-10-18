import 'package:descope/descope.dart';

Future startEnchantedLink() async {
  print('Start enchanted link');
  // If configured globally, the redirect URI is optional. If provided however, it will be used
// instead of any global configuration
  // final enchantedLinkResponse = await Descope.enchantedLink.signUpOrIn(
  //     loginId: '+18173740750');
  //      final authResponse = await Descope.enchantedLink
  //     .pollForSession(pendingRef: enchantedLinkResponse.pendingRef);
  //     final session = DescopeSession.fromAuthenticationResponse(authResponse);
  //     Descope.sessionManager.manageSession(session);

  // Descope.enchantedLink.signIn(
  //     loginId: loginId, uri: 'https://your-redirect-address.com/verify');
  // Descope.enchantedLink.signUpOrIn(
  //     loginId: loginId, uri: 'https://your-redirect-address.com/verify');
  // Descope.enchantedLink.updateEmail(
  //     email: "email",
  //     refreshJwt: Descope.sessionManager.session!.refreshJwt,
  //     loginId: loginId,
  //     uri: 'https://your-redirect-address.com/verify');

}

Future verifyEnchantedLink(
    String loginId, EnchantedLinkResponse enchantedLinkResponse) async {
  final authResponse = await Descope.enchantedLink
      .pollForSession(pendingRef: enchantedLinkResponse.pendingRef);
  return authResponse;
}
