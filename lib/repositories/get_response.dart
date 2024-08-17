import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../configs/app_constants.dart';

Future<String> getResponse({required String url, String? token, }) async {
  Uri uriUrl = Uri.parse(url);

  final Map<String, String> header = {
    "Content-Type": "application/json",
    if (token != null) 'Authorization': 'Bearer $token'
  };

  try {
    final response = await http.get(uriUrl, headers: header).timeout(const Duration(seconds: 15));
    logger.i("getResponse body: ${response.body}");
    return response.body;
  } on TimeoutException {
    return '''
{
   "success": false,
   "title": "Timeout",
   "message": "The request timed out. Please try again later.",
   "data": null
}
''';
  } on SocketException {
    return '''
{
   "success": false,
   "title": "Connection Failed",
   "message": "Unable to connect to the server. Please check your network connection and try again.",
   "data": null
}
''';
  } catch (e) {
    return '''
{
   "success": false,
   "title": "Failed",
   "message": "An error occurred while communicating with the server",
   "data": null
}
''';
  }
}
