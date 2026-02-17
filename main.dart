import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'services/service_account_parser.dart';

// import 'services/invoicing_service.dart';

Future<void> init(InternetAddress ip, int port) async {
  await ServiceAccountParser.parseServiceAccountFile();
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler, InternetAddress.anyIPv4, 8080);
}
