import 'dart:convert';
import 'dart:io';

class ServiceAccountParser {
  ServiceAccountParser();

  static late final Map<String, dynamic> serviceAccount;

  static Future<void> parseServiceAccountFile() async {
    const path = './public/service_account.json';

    final file = File(path);

    final open = await file.readAsString();

    serviceAccount = jsonDecode(open) as Map<String, dynamic>;
  }
}
