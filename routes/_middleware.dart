import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;

const spamRequests = [
  'favicon.ico',
  'robots.txt',
  'sitemap.xml',
  '.env',
];

Handler middleware(Handler handler, [String? frag]) {
  return handler
    ..use(badRequestHandler)
    ..use(requestLogger())
    ..use(
      fromShelfMiddleware(
        shelf.corsHeaders(
          headers: {
            shelf.ACCESS_CONTROL_ALLOW_ORIGIN: '*',
          },
        ),
      ),
    );
}

Handler badRequestHandler(Handler handler) {
  return (context) async {
    // Execute code before request is handled.
    final frag = context.request.url.pathSegments;
    late final Response response;
    for (final spam in spamRequests) {
      for (final fragment in frag) {
        if (spam == fragment) {
          response = Response.json(
            statusCode: HttpStatus.badRequest,
            body: {'message': 'bad request'},
          );
        } else {
          response = await handler(context);
        }
      }
    }

    return response;
  };
}
