import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

import '../services/service_account_parser.dart';

// Use service account credentials to obtain oauth credentials.
Future<AccessCredentials> obtainCredentials() async {
  final accountCredentials =
      ServiceAccountCredentials.fromJson(ServiceAccountParser.serviceAccount);

  const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  final client = http.Client();

  final credentials = await obtainAccessCredentialsViaServiceAccount(
    accountCredentials,
    scopes,
    client,
  );

  client.close();
  return credentials;
}
