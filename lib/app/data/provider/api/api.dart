
import 'package:get/get.dart';
import 'package:the_movie_app/app/config/constants.dart';
import 'package:the_movie_app/app/data/services/logs.dart';

import '../../helpers/enum.dart';

class API extends GetConnect {
  final String path;
  final Map<String, String>? headers;
  final Map<String, dynamic>? queryParam;
  final Map<String, dynamic>? bodyParam;
  final HTTPMethod httpMethod;

  API({
    this.path = '',
    this.headers,
    this.queryParam,
    this.bodyParam,
    this.httpMethod = HTTPMethod.get
  });

  final Map<String, String> _headers = {
    "accept": "application/json",
    "Authorization": "Bearer ${Constant.accessAuthToken}"
  };

  Future<dynamic> httpRequest() async {
    if (headers != null) {
      _headers.addEntries(headers!.entries);
    }
    switch (httpMethod) {
      case HTTPMethod.get:  
        final response = await get(
          Constant.baseURL + path,
          headers: _headers,
          query: queryParam
        );
        apiLog(method: HTTPMethod.get, url: Constant.baseURL + path, code: response.statusCode, queryParam: queryParam, bodyParam: bodyParam, response: response.body);
        return response;
      case HTTPMethod.post: 
        final response = await post(
          Constant.baseURL + path,
          bodyParam,
          headers: _headers,
          query: queryParam 
        );
        apiLog(method: HTTPMethod.post, url: Constant.baseURL + path, code: response.statusCode, queryParam: queryParam, bodyParam: bodyParam, response: response.body);
        return response;
    }
  }
}