import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';

import '../credentials/obtain_creds.dart';
import '../models/client_notification.dart';
import '../models/fcm_payload_from_client.dart';
import '../models/tokenized_notification.dart';
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
    //obtain access credentials from google auth api
    final accessCredentials = await obtainCredentials();
    // parse body to json
    final body = await context.request.json() as Map<String, dynamic>;
    // map the body to a client notificaiton
    final clientNotification = ClientNotification.fromJson(body);
    // initialize pocketbase instance
    final pb = PocketBase(clientNotification.server_url);
    // add notification from client to the clients backend
    await pb.collection('notifications').create(
          body: TokenizedNotification(
            id: '',
            message_id: const Uuid().v4(),
            title: clientNotification.message_title,
            body: clientNotification.message_body,
            user_token: clientNotification.client_token,
          ).toJson(),
        );
    // send notification request to fcm servers
    await FcmServerHandler(credentials: accessCredentials).sendFcmNotification(
      payload: FcmPayloadFromClient.fromClientNotification(clientNotification),
    );
    // return response to client
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
