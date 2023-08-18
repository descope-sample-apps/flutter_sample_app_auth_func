import 'package:descope/descope.dart';

Future startEnchantedLink(String loginId) async {
  // If configured globally, the redirect URI is optional. If provided however, it will be used
// instead of any global configuration
  final enchantedLinkResponse = await Descope.enchantedLink.signUp(
      loginId: loginId, uri: 'https://your-redirect-address.com/verify');

  Descope.enchantedLink.signUp(
      loginId: loginId, uri: 'https://your-redirect-address.com/verify');
  Descope.enchantedLink.signIn(
      loginId: loginId, uri: 'https://your-redirect-address.com/verify');
  Descope.enchantedLink.signUpOrIn(
      loginId: loginId, uri: 'https://your-redirect-address.com/verify');
  Descope.enchantedLink.updateEmail(
      email: "email",
      refreshJwt: Descope.sessionManager.session!.refreshJwt,
      loginId: loginId,
      uri: 'https://your-redirect-address.com/verify');

  return enchantedLinkResponse;
}

Future verifyEnchantedLink(
    String loginId, EnchantedLinkResponse enchantedLinkResponse) async {
  final authResponse = await Descope.enchantedLink
      .pollForSession(pendingRef: enchantedLinkResponse.pendingRef);
  return authResponse;
}
