import 'package:descope/descope.dart';

Future startMagicLInk() async {
  // If configured globally, the redirect URI is optional. If provided however, it will be used
// instead of any global configuration
  await Descope.magicLink.signUp(
      method: DeliveryMethod.email,
      loginId: 'desmond_c@mail.com',
      uri: 'https://your-redirect-address.com/verify');
}

Future verifyMagicLink() async {
  // To verify a magic link, your redirect page must call the validation function on the token (t) parameter (https://your-redirect-address.com/verify?t=<token>):
  final authResponse = await Descope.magicLink.verify(token: '<token>');
  return authResponse;
}
