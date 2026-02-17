// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:convert';

import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;

import '../models/fcm_payload_from_client.dart';

const fcm_uri =
    'https://fcm.googleapis.com/v1/projects/proklinik-one/messages:send';

class FcmServerHandler {
  const FcmServerHandler({required this.credentials});

  final AccessCredentials credentials;

  Future<void> sendFcmNotification({
    required FcmPayloadFromClient payload,
  }) async {
    await http.post(
      Uri.parse(fcm_uri),
      headers: {
        'Authorization': 'Bearer ${credentials.accessToken.data}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload.toJson()),
    );
  }
}
