import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../credentials/obtain_creds.dart';
import '../models/client_notification.dart';
import '../models/fcm_payload_from_client.dart';
import '../services/fcm_server_handler.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _handlePostRequest(context);
  } else {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: {'message': 'Method Not Allowed.'},
    );
  }
}

Future<Response> _handlePostRequest(RequestContext context) async {
  try {
    final accessCredentials = await obtainCredentials();

    final body = await context.request.json() as Map<String, dynamic>;

    final clientNotification = ClientNotification.fromJson(body);

    await FcmServerHandler(credentials: accessCredentials).sendFcmNotification(
      payload: FcmPayloadFromClient.fromClientNotification(clientNotification),
    );

    return Response.json(
      body: {'message': 'success'},
    );
    // ignore: unused_catch_stack
  } catch (e, s) {
    // print(e);
    // print(s);
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'message': 'missing request parameters.',
        'code': 001,
      },
    );
  }
}
