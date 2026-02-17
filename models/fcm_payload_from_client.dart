// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import 'client_notification.dart';

class FcmPayloadFromClient extends Equatable {
  const FcmPayloadFromClient({
    required this.title,
    required this.body,
    required this.client_token,
    this.data = const {},
  });

  factory FcmPayloadFromClient.fromClientNotification(ClientNotification n) {
    return FcmPayloadFromClient(
      title: n.message_title,
      body: n.message_body,
      client_token: n.client_token,
    );
  }
  final String title;
  final String body;
  final String client_token;
  final Map<String, dynamic> data;

  FcmPayloadFromClient copyWith({
    String? title,
    String? body,
    String? client_token,
    Map<String, dynamic>? data,
  }) {
    return FcmPayloadFromClient(
      body: body ?? this.body,
      title: title ?? this.title,
      client_token: client_token ?? this.client_token,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        title,
        body,
        client_token,
        data,
      ];

  Map<String, dynamic> toJson() {
    return {
      'message': {
        'token': client_token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': data,
      },
    };
  }
}
