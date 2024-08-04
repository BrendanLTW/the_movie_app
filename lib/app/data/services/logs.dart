import 'dart:convert';

import 'package:talker/talker.dart';

import '../helpers/enum.dart';

class ApiLog extends TalkerLog {
  final HTTPMethod method;

  ApiLog(message, {this.method = HTTPMethod.post}) : super(message);

  int? _color;

  @override
  String get title {
    switch (method) {
      case HTTPMethod.get:
        _color = 010;
        return 'GET';
      case HTTPMethod.post:
        _color = 226;
        return 'POST';
    }
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(_color ?? 226);
}

final talker = Talker();

apiLog({
  HTTPMethod? method,
  String? url,
  int? code,
  Map<String, dynamic>? queryParam,
  Map<String, dynamic>? bodyParam,
  dynamic response,
}) {
  talker.logTyped(ApiLog(
      '\nUrl      : $url \nCode     : $code \nQuery    : ${json.encode(queryParam)} \nRequest  : ${json.encode(bodyParam)} \nResponse : $response ',
      method: method ?? HTTPMethod.post));
}
