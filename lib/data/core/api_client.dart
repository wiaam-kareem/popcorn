import 'dart:convert';

import 'package:http/http.dart';

import 'api_constants.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);
  dynamic get(String path) async {
    final url = '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}';
    final response = await _client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
