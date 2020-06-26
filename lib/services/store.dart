import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> saveConnectionData(
  String address,
  String webKey,
) async {
  final storage = new FlutterSecureStorage();
  // Remove old values
  await storage.deleteAll();
  // Save values
  await storage.write(key: "address", value: address);
  await storage.write(key: "webKey", value: webKey);
}

Future<String> getAddress() async {
  final storage = new FlutterSecureStorage();
  // Read value
  String address = await storage.read(key: "address");
  return address;
}

Future<String> getWebKey() async {
  final storage = new FlutterSecureStorage();
  // Read value
  String webKey = await storage.read(key: "webKey");
  return webKey;
}
