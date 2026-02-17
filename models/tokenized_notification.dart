// ignore_for_file: non_constant_identifier_names, public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class TokenizedNotification extends Equatable {
  final String id;
  final String message_id;
  final String title;
  final String body;
  final String user_token;
  final List<String> read_by;

  const TokenizedNotification({
    required this.id,
    required this.message_id,
    required this.title,
    required this.body,
    required this.user_token,
    this.read_by = const [],
  });

  TokenizedNotification copyWith({
    String? id,
    String? message_id,
    String? title,
    String? body,
    String? user_token,
  }) {
    return TokenizedNotification(
      id: id ?? this.id,
      message_id: message_id ?? this.message_id,
      title: title ?? this.title,
      body: body ?? this.body,
      user_token: user_token ?? this.user_token,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'message_id': message_id,
      'title': title,
      'body': body,
      'user_token': user_token,
      'read_by': const <String>[]
    };
  }

  factory TokenizedNotification.fromJson(Map<String, dynamic> map) {
    return TokenizedNotification(
      id: map['id'] as String,
      message_id: map['message_id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      user_token: map['user_token'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      message_id,
      title,
      body,
      user_token,
      read_by,
    ];
  }
}
