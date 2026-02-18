import 'dart:math';

class OtpGenerator {
  static String generate() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random.secure();

    return List.generate(
      4,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }
}
